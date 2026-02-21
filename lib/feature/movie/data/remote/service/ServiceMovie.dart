import 'package:dio/dio.dart';
import 'package:movie_app/core/DioClient.dart';
import 'package:movie_app/core/language/language_store_instance.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/DetailMovieResponse.dart';
import 'package:movie_app/feature/movie/data/remote/model/CastMovieResponse.dart';

class ServiceMovie {
  Map<String, dynamic> _getBaseQueryParameters(Map<String, dynamic>? additionalParams) {
    final baseParams = <String, dynamic>{};
    
    // Add language parameter if Indonesian is selected
    if (languageStore.selectedLanguage == 'id') {
      baseParams['language'] = 'id-ID';
    }
    
    // Add additional parameters if provided
    if (additionalParams != null) {
      baseParams.addAll(additionalParams);
    }
    
    return baseParams;
  }

  Future<MovieResponse> getMovies(
    String type,
    int page,
  ) async {
    final response = await DioClient.dio.get(
      "/movie/$type",
      queryParameters: _getBaseQueryParameters({
        "page": page,
      }),
    );

    return MovieResponse.fromJson(response.data);
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response = await DioClient.dio.get(
      "/movie/$movieId",
      queryParameters: _getBaseQueryParameters(null),
    );
    return MovieDetail.fromJson(response.data);
  }

  Future<MovieResponse> getSimilarMovies(int movieId) async {
    final response = await DioClient.dio.get(
      "/movie/$movieId/similar",
      queryParameters: _getBaseQueryParameters(null),
    );
    return MovieResponse.fromJson(response.data);
  }

  Future<CastMovieResponse> getMovieCast(int movieId) async {
    final response = await DioClient.dio.get(
      "/movie/$movieId/credits",
      queryParameters: _getBaseQueryParameters(null),
    );
    return CastMovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> searchMovies(String query, int page) async {
    final response = await DioClient.dio.get(
      "/search/movie",
      queryParameters: _getBaseQueryParameters({
        "query": query,
        "page": page,
      }),
    );

    return MovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> discoverMovies(String sortBy, int page) async {
    final response = await DioClient.dio.get(
      "/discover/movie",
      queryParameters: _getBaseQueryParameters({
        "sort_by": sortBy,
        "page": page,
      }),
    );

    return MovieResponse.fromJson(response.data);
  }
}