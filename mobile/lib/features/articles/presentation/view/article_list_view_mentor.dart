import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/utils/article.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/articles/presentation/view/article_view.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleListMentor extends ConsumerStatefulWidget {
  const ArticleListMentor({super.key});

  @override
  ConsumerState<ArticleListMentor> createState() => _ArticleListMentorState();
}

class _ArticleListMentorState extends ConsumerState<ArticleListMentor> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(articleViewModelProvider.notifier).getAllArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(articleViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.message != "" && state.showMessage) {
        SnackBarManager.showSnackBar(
            isError: state.isError, message: state.message, context: context);
        ref.read(articleViewModelProvider.notifier).resetState();
      }
    });
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(articleViewModelProvider.notifier).getAllArticles();
          }
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Articles"),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Article(
                                      articleEntity: state.article[index],
                                    )),
                          );
                        },
                        child: ArticleContainer(
                            profile: state.article[index].profileUrl,
                            body: state.article[index].body,
                            title: state.article[index].title,
                            mentor: state.article[index].mentorName),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                    itemCount: state.article.length),
              ),
              if (state.isLoading)
                const CircularProgressIndicator(color: Colors.yellow),
              const SizedBox(height: 10),
            ],
          ),
          floatingActionButton: DraggableFab(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFEEA025),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addArticle);
              },
              child: const Icon(
                Icons.add,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
