import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddArticleView extends ConsumerStatefulWidget {
  const AddArticleView({super.key});

  @override
  ConsumerState<AddArticleView> createState() => _AddArticleViewState();
}

class _AddArticleViewState extends ConsumerState<AddArticleView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    final form = GlobalKey<FormState>();

    final articleState = ref.watch(articleViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (articleState.showMessage) {
        SnackBarManager.showSnackBar(
            message: articleState.message,
            context: context,
            isError: articleState.isError);
        ref.read(articleViewModelProvider.notifier).resetState();
      }
    });

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.clear,
                color: Color(0xFFEEA025),
                size: 40,
              ),
            ),
            actions: [
              Container(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () async {
                      final currentContext = context;
                      if (form.currentState!.validate()) {
                        final user = await ref
                            .read(userSharedPrefsProvider)
                            .getUserDetails();
                        user.fold((failure) {
                          return SnackBarManager.showSnackBar(
                              isError: true,
                              message: "Token Invalid",
                              context: currentContext);
                        }, (user) {
                          print(user);
                          var article = ArticleEntity(
                              mentorId: user['_id'],
                              mentorEmail: user['email'],
                              mentorName:
                                  '${user['mentorProfileInformation']['firstName']} ${user['mentorProfileInformation']['lastName']}',
                              profileUrl: user['profileUrl'],
                              title: titleController.text,
                              body: bodyController.text);
                          print(article);
                          ref
                              .read(articleViewModelProvider.notifier)
                              .addArticle(article);
                        });
                      }
                    },
                    child: const Text("Post")),
              )
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        style: const TextStyle(fontSize: 20),
                        // controller: ti,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "title is invalid";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red[900]),
                          labelText: "Title...",
                          labelStyle: const TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromARGB(255, 139, 117, 169)),
                          border: const OutlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: bodyController,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: null,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "body is invalid";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red[900]),
                            labelStyle: const TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromARGB(255, 139, 117, 169),
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (articleState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          )),
    );
  }
}
