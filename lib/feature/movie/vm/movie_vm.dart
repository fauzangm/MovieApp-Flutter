import 'package:mobx/mobx.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieModel.dart';
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

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchMovies(String type, {bool isLoadMore = false}) async {
    try {
      if (isLoading) return;
      if (!isLoadMore) {
        _movies.clear();
        _currentPage = 1;
        _totalPages = 1;
        _currentType = type;
      }

      if (_currentPage > _totalPages) return;

      isLoading = true;
      errorMessage = null;

      final MovieResponse response =
          await _service.getMovies(_currentType, _currentPage);

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

  void dispose() {
    _movieSubject.close();
  }
}