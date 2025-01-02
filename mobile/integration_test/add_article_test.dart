import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/usecases/add_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/delete_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/get_articles_use_case.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import '../build/unit_test_assets/test_data/article_entity_test.dart';
import '../test/unit_test/article_unit_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AddArticleUsecase mockAddArticleUsecase;
  late DeleteArticleUseCase mockDeleteArticleUseCase;
  late GetAllArticleUseCase mockGetAllArticleUseCase;
  late ConnectivityStatusNotifier mockConnectivityStatusNotifier;
  late List<ArticleEntity> lstArticle;


  setUpAll(() async {
    mockAddArticleUsecase = MockAddArticleUsecase();
    mockDeleteArticleUseCase = MockDeleteArticleUseCase();
    mockGetAllArticleUseCase = MockGetAllArticleUseCase();
    mockConnectivityStatusNotifier = MockConnectivityStatusNotifier();
    lstArticle = await getArticleListTest();
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAddArticleUsecase.addArticle(ArticleEntity(
            title: "Test",
            body: "Test",
            mentorId: "mentorId",
            mentorName: "mentorName",
            mentorEmail: "mentorEmail",
            profileUrl: "profileUrl")))
        .thenAnswer((_) async => const Right(true));


    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          articleViewModelProvider.overrideWith((ref) => ArticleViewModel(
              addArticleUsecase: mockAddArticleUsecase,
              getAllArticleUseCase: mockGetAllArticleUseCase,
              deleteArticleUseCase: mockDeleteArticleUseCase,
              connectivityStatus: mockConnectivityStatusNotifier.state))
        ],
        child: MaterialApp(
          initialRoute: AppRoutes.addArticle,
          routes: AppRoutes.getApplicationRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), "Test");
    await tester.enterText(find.byType(TextField).at(1), "Test");

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Post'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Token Invalid'), findsOneWidget);
  });
}
