import 'package:app/core/utils/article.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/articles/presentation/view/article_view.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleList extends ConsumerStatefulWidget {
  const ArticleList({super.key});

  @override
  ConsumerState<ArticleList> createState() => _ArticleListMentorState();
}

class _ArticleListMentorState extends ConsumerState<ArticleList> {
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
          // Scroll garda feri last ma ho ki haina bhanera check garne ani data call garne
          if (_scrollController.position.extentAfter == 0) {
            // Data fetch gara api bata
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
        ),
      ),
    );
  }
}
