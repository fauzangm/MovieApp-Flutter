// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookmarkVM on _BookmarkVM, Store {
  late final _$isLoadingAtom = Atom(
    name: '_BookmarkVM.isLoading',
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

  late final _$errorMessageAtom = Atom(
    name: '_BookmarkVM.errorMessage',
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

  late final _$bookmarkedIdsAtom = Atom(
    name: '_BookmarkVM.bookmarkedIds',
    context: context,
  );

  @override
  Set<int> get bookmarkedIds {
    _$bookmarkedIdsAtom.reportRead();
    return super.bookmarkedIds;
  }

  @override
  set bookmarkedIds(Set<int> value) {
    _$bookmarkedIdsAtom.reportWrite(value, super.bookmarkedIds, () {
      super.bookmarkedIds = value;
    });
  }

  late final _$loadBookmarksAsyncAction = AsyncAction(
    '_BookmarkVM.loadBookmarks',
    context: context,
  );

  @override
  Future<void> loadBookmarks() {
    return _$loadBookmarksAsyncAction.run(() => super.loadBookmarks());
  }

  late final _$toggleBookmarkAsyncAction = AsyncAction(
    '_BookmarkVM.toggleBookmark',
    context: context,
  );

  @override
  Future<void> toggleBookmark(Movie movie) {
    return _$toggleBookmarkAsyncAction.run(() => super.toggleBookmark(movie));
  }

  late final _$isBookmarkedAsyncAction = AsyncAction(
    '_BookmarkVM.isBookmarked',
    context: context,
  );

  @override
  Future<bool> isBookmarked(int movieId) {
    return _$isBookmarkedAsyncAction.run(() => super.isBookmarked(movieId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
bookmarkedIds: ${bookmarkedIds}
    ''';
  }
}
