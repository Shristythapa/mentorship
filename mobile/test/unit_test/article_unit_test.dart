import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/usecases/add_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/delete_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/get_articles_use_case.dart';
import 'package:app/features/articles/presentation/viewmodel/article_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/article_entity_test.dart';
import 'article_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddArticleUsecase>(),
  MockSpec<DeleteArticleUseCase>(),
  MockSpec<GetAllArticleUseCase>(),
  MockSpec<ConnectivityStatusNotifier>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
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

    when(mockGetAllArticleUseCase.getAllArticle(1, 3))
        .thenAnswer((realInvocation) => Future.value(const Right([])));

    container = ProviderContainer(overrides: [
      articleViewModelProvider.overrideWith((ref) => ArticleViewModel(
          addArticleUsecase: mockAddArticleUsecase,
          getAllArticleUseCase: mockGetAllArticleUseCase,
          deleteArticleUseCase: mockDeleteArticleUseCase,
          connectivityStatus: mockConnectivityStatusNotifier.state))
    ]);
  });

  test('check session initial state', () async {
    await container.read(articleViewModelProvider.notifier).getAllArticles();

    final articleState = container.read(articleViewModelProvider);
    expect(articleState.isLoading, false);
    expect(articleState.article, isEmpty);
  });


  test('add session test', () async {
    when(mockAddArticleUsecase.addArticle(lstArticle[0]))
        .thenAnswer((_) => Future.value(const Right(true)));
    container.read(articleViewModelProvider.notifier).addArticle(lstArticle[0]);

    final articleState = container.read(articleViewModelProvider);

    expect(articleState.isError, false);
  });

   test('delete session test', () async {
    when(mockDeleteArticleUseCase.deleteArticle('id'))
        .thenAnswer((realInvocation) => Future.value(const Right(true)));
    await container
        .read(articleViewModelProvider.notifier)
        .deleteArticle('id');

    final state = container.read(articleViewModelProvider);
    print(state);
    expect(state.isError, false);
  });
}
