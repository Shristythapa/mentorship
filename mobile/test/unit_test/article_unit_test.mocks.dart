// Mocks generated by Mockito 5.4.4 from annotations
// in app/test/unit_test/article_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:app/core/error/failure.dart' as _i6;
import 'package:app/core/provider/internet_connectivity.dart' as _i10;
import 'package:app/features/articles/domain/entity/article_entity.dart' as _i7;
import 'package:app/features/articles/domain/repository/article_repository.dart'
    as _i2;
import 'package:app/features/articles/domain/usecases/add_article_use_case.dart'
    as _i4;
import 'package:app/features/articles/domain/usecases/delete_article_use_case.dart'
    as _i8;
import 'package:app/features/articles/domain/usecases/get_articles_use_case.dart'
    as _i9;
import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIArticleRepository_0 extends _i1.SmartFake
    implements _i2.IArticleRepository {
  _FakeIArticleRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddArticleUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddArticleUsecase extends _i1.Mock implements _i4.AddArticleUsecase {
  @override
  _i2.IArticleRepository get articleRepository => (super.noSuchMethod(
        Invocation.getter(#articleRepository),
        returnValue: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#articleRepository),
        ),
        returnValueForMissingStub: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#articleRepository),
        ),
      ) as _i2.IArticleRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> addArticle(
          _i7.ArticleEntity? articleEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #addArticle,
          [articleEntity],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addArticle,
            [articleEntity],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addArticle,
            [articleEntity],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);
}

/// A class which mocks [DeleteArticleUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteArticleUseCase extends _i1.Mock
    implements _i8.DeleteArticleUseCase {
  @override
  _i2.IArticleRepository get articleRepository => (super.noSuchMethod(
        Invocation.getter(#articleRepository),
        returnValue: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#articleRepository),
        ),
        returnValueForMissingStub: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#articleRepository),
        ),
      ) as _i2.IArticleRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> deleteArticle(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteArticle,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #deleteArticle,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #deleteArticle,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);
}

/// A class which mocks [GetAllArticleUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllArticleUseCase extends _i1.Mock
    implements _i9.GetAllArticleUseCase {
  @override
  _i2.IArticleRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeIArticleRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IArticleRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.ArticleEntity>>> getAllArticle(
    int? page,
    int? limit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllArticle,
          [
            page,
            limit,
          ],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ArticleEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ArticleEntity>>(
          this,
          Invocation.method(
            #getAllArticle,
            [
              page,
              limit,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ArticleEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ArticleEntity>>(
          this,
          Invocation.method(
            #getAllArticle,
            [
              page,
              limit,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.ArticleEntity>>>);
}

/// A class which mocks [ConnectivityStatusNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectivityStatusNotifier extends _i1.Mock
    implements _i10.ConnectivityStatusNotifier {
  @override
  _i10.ConnectivityStatus get lastResult => (super.noSuchMethod(
        Invocation.getter(#lastResult),
        returnValue: _i10.ConnectivityStatus.notDetermined,
        returnValueForMissingStub: _i10.ConnectivityStatus.notDetermined,
      ) as _i10.ConnectivityStatus);

  @override
  set lastResult(_i10.ConnectivityStatus? _lastResult) => super.noSuchMethod(
        Invocation.setter(
          #lastResult,
          _lastResult,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.ConnectivityStatus get newState => (super.noSuchMethod(
        Invocation.getter(#newState),
        returnValue: _i10.ConnectivityStatus.notDetermined,
        returnValueForMissingStub: _i10.ConnectivityStatus.notDetermined,
      ) as _i10.ConnectivityStatus);

  @override
  set newState(_i10.ConnectivityStatus? _newState) => super.noSuchMethod(
        Invocation.setter(
          #newState,
          _newState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onError(_i11.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i5.Stream<_i10.ConnectivityStatus> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i10.ConnectivityStatus>.empty(),
        returnValueForMissingStub: _i5.Stream<_i10.ConnectivityStatus>.empty(),
      ) as _i5.Stream<_i10.ConnectivityStatus>);

  @override
  _i10.ConnectivityStatus get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i10.ConnectivityStatus.notDetermined,
        returnValueForMissingStub: _i10.ConnectivityStatus.notDetermined,
      ) as _i10.ConnectivityStatus);

  @override
  set state(_i10.ConnectivityStatus? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.ConnectivityStatus get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: _i10.ConnectivityStatus.notDetermined,
        returnValueForMissingStub: _i10.ConnectivityStatus.notDetermined,
      ) as _i10.ConnectivityStatus);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void setStateForTesting(_i10.ConnectivityStatus? newState) =>
      super.noSuchMethod(
        Invocation.method(
          #setStateForTesting,
          [newState],
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool updateShouldNotify(
    _i10.ConnectivityStatus? old,
    _i10.ConnectivityStatus? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i11.RemoveListener addListener(
    _i12.Listener<_i10.ConnectivityStatus>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
        returnValueForMissingStub: () {},
      ) as _i11.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
