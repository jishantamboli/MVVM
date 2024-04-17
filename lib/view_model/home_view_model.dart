import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MovieListmodel> moviesList = ApiResponse.loading();
  setMoviesList(ApiResponse<MovieListmodel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myRepo
        .moviesapi()
        .then((value) => {setMoviesList(ApiResponse.completed(value))})
        .onError((error, stackTrace) {
     return setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
