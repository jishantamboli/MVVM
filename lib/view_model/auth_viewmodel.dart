import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();
  bool _loading = false;
  bool _signuploading = false;
  bool get signuploading => _signuploading;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignupLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  Future<void> loginapi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.loginapi(data).then((value) {
      setLoading(false);
      final userpreferance = Provider.of<UserViewModel>(context, listen: false);
      userpreferance.saveUser(
        UserModel(token: value['token'].toString())
      );
      if (kDebugMode) {
        Utils.toastMessage("Login Successfully");
        Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        // Utils.toastMessage(error.toString());
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signupapi(dynamic data, BuildContext context) async {
    setsignupLoading(true);
    _myrepo.registerapi(data).then((value) {
      setLoading(false);
      final userpreferance = Provider.of<UserViewModel>(context, listen: false);
      userpreferance.saveUser(
        UserModel(token: value['token'].toString())
      );
      if (kDebugMode) {
        Utils.toastMessage("SignUp Successfully");
        Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setsignupLoading(false);
      if (kDebugMode) {
        // Utils.toastMessage(error.toString());
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
