import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Article extends ConsumerStatefulWidget {
  ArticleEntity articleEntity;
  Article({super.key, required this.articleEntity});

  @override
  ConsumerState<Article> createState() => _ArticleState();
}

class _ArticleState extends ConsumerState<Article> {
  late dynamic user; // Declare a variable to store the user information

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  Future<void> _getUserDetails() async {
    var userResult = await ref.read(userSharedPrefsProvider).getUserDetails();
    userResult.fold(
      (failure) {
        SnackBarManager.showSnackBar(
          isError: true,
          message: "Token Invalid",
          context: context,
        );
      },
      (fetchedUser) {
        setState(() {
          user = fetchedUser; // Update the user variable with fetched user
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.articleEntity.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.articleEntity.profileUrl),
                        radius: 20,
                      ),
                    ),
                    Text(
                      widget.articleEntity.mentorName,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.articleEntity.body),
                user != null &&
                        user['email'] == widget.articleEntity.mentorEmail
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(articleViewModelProvider.notifier)
                                .deleteArticle(widget.articleEntity.id!);
                          },
                          child: const Text("Delete"),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
