import 'package:dio/dio.dart';
import 'package:movie_app/core/DioClient.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieModel.dart';

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
}