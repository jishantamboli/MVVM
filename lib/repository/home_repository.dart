import 'package:mvvm/model/movies_model.dart';

import '../data/netwrok/BaseApiServices.dart';
import '../data/netwrok/NetworkApiServices.dart';
import '../res/components/app_url.dart';

class HomeRepository{
   BaseApiServices _apiServices = NetworkApiService();

   Future<MovieListmodel> moviesapi() async {
    try {
      dynamic response =
          await _apiServices.getGetResponse(AppUrl.movieurl,);
      return response = MovieListmodel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}