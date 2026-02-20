import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      headers: {
        "Authorization": "Bearer ${dotenv.env['TMDB_ACCESS_TOKEN']}",
        "Content-Type": "application/json",
      },
    ),
  );
}