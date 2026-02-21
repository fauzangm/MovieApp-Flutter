import 'package:mobx/mobx.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/DetailMovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/CastMovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/service/ServiceMovie.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_vm.g.dart';

class MovieVM = _MovieVM with _$MovieVM;

abstract class _MovieVM with Store {
  final ServiceMovie _service = ServiceMovie();

  final BehaviorSubject<List<Movie>> _movieSubject =
      BehaviorSubject.seeded([]);

  Stream<List<Movie>> get movieStream => _movieSubject.stream;

  final List<Movie> _movies = [];

  int _currentPage = 1;
  int _totalPages = 1;
  String _currentType = "popular";
  String _currentSort = "idle";
  String? _currentQuery;

  @observable
  bool isLoading = false;

  // Detail states
  @observable
  MovieDetail? movieDetail;

  @observable
  List<Movie> similarMovies = [];

  @observable
  List<CastModel> cast = [];

  @observable
  bool isLoadingDetail = false;

  @observable
  bool isLoadingSimilar = false;

  @observable
  bool isLoadingCast = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchMovies({
    String? type,
    String? sortBy,
    String? query,
    bool isLoadMore = false,
  }) async {
    try {
      if (isLoading) return;
      if (!isLoadMore) {
        _movies.clear();
        _currentPage = 1;
        _totalPages = 1;
        if (type != null) _currentType = type;
        if (sortBy != null) _currentSort = sortBy;
        if (query != null) {
          _currentQuery = query;
        } else {
          // saat tidak ada query, pastikan _currentQuery di-clear agar tidak stuck di mode search
          _currentQuery = null;
        }
      }

      if (_currentPage > _totalPages) return;

      isLoading = true;
      errorMessage = null;

      MovieResponse response;
      if (_currentQuery != null) {
        response = await _service.searchMovies(_currentQuery!, _currentPage);
      } else if (_currentSort != 'idle' && _currentSort.isNotEmpty) {
        response = await _service.discoverMovies(_currentSort, _currentPage);
      } else {
        response = await _service.getMovies(_currentType, _currentPage);
      }

      _totalPages = response.totalPages;
      _currentPage++;

      _movies.addAll(response.results);

      // Emit copy supaya stream detect change
      _movieSubject.add(List.from(_movies));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchMovieDetail(int movieId) async {
    try {
      isLoadingDetail = true;
      errorMessage = null;
      movieDetail = await _service.getMovieDetail(movieId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingDetail = false;
    }
  }

  @action
  Future<void> fetchSimilarMovies(int movieId) async {
    try {
      isLoadingSimilar = true;
      errorMessage = null;
      final response = await _service.getSimilarMovies(movieId);
      similarMovies = response.results;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingSimilar = false;
    }
  }

  @action
  Future<void> fetchMovieCast(int movieId) async {
    try {
      isLoadingCast = true;
      errorMessage = null;
      final castResponse = await _service.getMovieCast(movieId);
      cast = castResponse.cast;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingCast = false;
    }
  }

  void dispose() {
    _movieSubject.close();
  }
}