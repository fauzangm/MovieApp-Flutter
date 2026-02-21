// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieVM on _MovieVM, Store {
  late final _$isLoadingAtom = Atom(
    name: '_MovieVM.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$movieDetailAtom = Atom(
    name: '_MovieVM.movieDetail',
    context: context,
  );

  @override
  MovieDetail? get movieDetail {
    _$movieDetailAtom.reportRead();
    return super.movieDetail;
  }

  @override
  set movieDetail(MovieDetail? value) {
    _$movieDetailAtom.reportWrite(value, super.movieDetail, () {
      super.movieDetail = value;
    });
  }

  late final _$similarMoviesAtom = Atom(
    name: '_MovieVM.similarMovies',
    context: context,
  );

  @override
  List<Movie> get similarMovies {
    _$similarMoviesAtom.reportRead();
    return super.similarMovies;
  }

  @override
  set similarMovies(List<Movie> value) {
    _$similarMoviesAtom.reportWrite(value, super.similarMovies, () {
      super.similarMovies = value;
    });
  }

  late final _$castAtom = Atom(name: '_MovieVM.cast', context: context);

  @override
  List<CastModel> get cast {
    _$castAtom.reportRead();
    return super.cast;
  }

  @override
  set cast(List<CastModel> value) {
    _$castAtom.reportWrite(value, super.cast, () {
      super.cast = value;
    });
  }

  late final _$isLoadingDetailAtom = Atom(
    name: '_MovieVM.isLoadingDetail',
    context: context,
  );

  @override
  bool get isLoadingDetail {
    _$isLoadingDetailAtom.reportRead();
    return super.isLoadingDetail;
  }

  @override
  set isLoadingDetail(bool value) {
    _$isLoadingDetailAtom.reportWrite(value, super.isLoadingDetail, () {
      super.isLoadingDetail = value;
    });
  }

  late final _$isLoadingSimilarAtom = Atom(
    name: '_MovieVM.isLoadingSimilar',
    context: context,
  );

  @override
  bool get isLoadingSimilar {
    _$isLoadingSimilarAtom.reportRead();
    return super.isLoadingSimilar;
  }

  @override
  set isLoadingSimilar(bool value) {
    _$isLoadingSimilarAtom.reportWrite(value, super.isLoadingSimilar, () {
      super.isLoadingSimilar = value;
    });
  }

  late final _$isLoadingCastAtom = Atom(
    name: '_MovieVM.isLoadingCast',
    context: context,
  );

  @override
  bool get isLoadingCast {
    _$isLoadingCastAtom.reportRead();
    return super.isLoadingCast;
  }

  @override
  set isLoadingCast(bool value) {
    _$isLoadingCastAtom.reportWrite(value, super.isLoadingCast, () {
      super.isLoadingCast = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_MovieVM.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchMoviesAsyncAction = AsyncAction(
    '_MovieVM.fetchMovies',
    context: context,
  );

  @override
  Future<void> fetchMovies({
    String? type,
    String? sortBy,
    String? query,
    bool isLoadMore = false,
  }) {
    return _$fetchMoviesAsyncAction.run(
      () => super.fetchMovies(
        type: type,
        sortBy: sortBy,
        query: query,
        isLoadMore: isLoadMore,
      ),
    );
  }

  late final _$fetchMovieDetailAsyncAction = AsyncAction(
    '_MovieVM.fetchMovieDetail',
    context: context,
  );

  @override
  Future<void> fetchMovieDetail(int movieId) {
    return _$fetchMovieDetailAsyncAction.run(
      () => super.fetchMovieDetail(movieId),
    );
  }

  late final _$fetchSimilarMoviesAsyncAction = AsyncAction(
    '_MovieVM.fetchSimilarMovies',
    context: context,
  );

  @override
  Future<void> fetchSimilarMovies(int movieId) {
    return _$fetchSimilarMoviesAsyncAction.run(
      () => super.fetchSimilarMovies(movieId),
    );
  }

  late final _$fetchMovieCastAsyncAction = AsyncAction(
    '_MovieVM.fetchMovieCast',
    context: context,
  );

  @override
  Future<void> fetchMovieCast(int movieId) {
    return _$fetchMovieCastAsyncAction.run(() => super.fetchMovieCast(movieId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
movieDetail: ${movieDetail},
similarMovies: ${similarMovies},
cast: ${cast},
isLoadingDetail: ${isLoadingDetail},
isLoadingSimilar: ${isLoadingSimilar},
isLoadingCast: ${isLoadingCast},
errorMessage: ${errorMessage}
    ''';
  }
}
