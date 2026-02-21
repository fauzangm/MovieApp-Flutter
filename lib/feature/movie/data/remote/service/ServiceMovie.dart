import 'package:dio/dio.dart';
import 'package:movie_app/core/DioClient.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/DetailMovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/CastMovieResponse.dart';

class ServiceMovie {
  Future<MovieResponse> getMovies(
    String type,
    int page,
  ) async {
    final response = await DioClient.dio.get(
      "/movie/$type",
      queryParameters: {
        "page": page,
      },
    );

    return MovieResponse.fromJson(response.data);
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response = await DioClient.dio.get("/movie/$movieId");
    return MovieDetail.fromJson(response.data);
  }

  Future<MovieResponse> getSimilarMovies(int movieId) async {
    final response = await DioClient.dio.get("/movie/$movieId/similar");
    return MovieResponse.fromJson(response.data);
  }

  Future<CastMovieResponse> getMovieCast(int movieId) async {
    final response = await DioClient.dio.get("/movie/$movieId/credits");
    return CastMovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> searchMovies(String query, int page) async {
    final response = await DioClient.dio.get(
      "/search/movie",
      queryParameters: {
        "query": query,
        "page": page,
      },
    );

    return MovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> discoverMovies(String sortBy, int page) async {
    final response = await DioClient.dio.get(
      "/discover/movie",
      queryParameters: {
        "sort_by": sortBy,
        "page": page,
      },
    );

    return MovieResponse.fromJson(response.data);
  }
}