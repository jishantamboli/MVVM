import 'package:mvvm/data/netwrok/BaseApiServices.dart';
import 'package:mvvm/data/netwrok/NetworkApiServices.dart';
import 'package:mvvm/res/components/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginapi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrl.loginurl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

   Future<dynamic> registerapi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrl.registerurl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
