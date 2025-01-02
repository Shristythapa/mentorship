import 'package:app/config/constants/hive_table_constant.dart';
import 'package:app/features/articles/data/model/article_hive_model.dart';
import 'package:app/features/mentee/data/model/mentee_hive_model.dart';
import 'package:app/features/sessions/data/model/session_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationCacheDirectory();
    print('directory-----------$directory');

    Hive.init(directory.path);
    registerAdapters();
  }

//register adapter to convert dart to binary to store in hive
  void registerAdapters() {
    Hive.registerAdapter(ArticleHiveModelAdapter());

    Hive.registerAdapter(SessionHiveModelAdapter());
  }

  Future<void> addSession(SessionHiveModel session) async {
    print("sesssssssssssssss ${session.title}");
    try {
      var box = await Hive.openBox<SessionHiveModel>(
          HiveTableConstant.sessionTableBox);
      await box.put(session.sessionId, session);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<SessionHiveModel>> getAllSessions() async {
    var box =
        await Hive.openBox<SessionHiveModel>(HiveTableConstant.sessionTableBox);
    var sessions = box.values.toList();
    print("got sessions $sessions");
    return sessions;
  }

  Future<void> addArticle(ArticleHiveModel article) async {
    print("article ${article.title}");
    var box =
        await Hive.openBox<ArticleHiveModel>(HiveTableConstant.articleTableBox);
    await box.put(article.id, article);
    print('added');
  }

  Future<List<ArticleHiveModel>> getAllArticle() async {
    var box =
        await Hive.openBox<ArticleHiveModel>(HiveTableConstant.articleTableBox);
    var article = box.values.toList();
    // box.close();
    print("got sessions $article");
    return article;
  }

  Future<void> deleteArticle(String id) async {
    var box = await Hive.openBox<ArticleHiveModel>(HiveTableConstant.articleTableBox);
    await box.delete(id);
  }
}
