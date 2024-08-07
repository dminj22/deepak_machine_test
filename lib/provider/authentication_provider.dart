import 'dart:js';

import 'package:deepak_machine_test/screen/dashboard/dashboard_screen.dart';
import 'package:deepak_machine_test/screen/authentication/login_screen.dart';
import 'package:deepak_machine_test/services/api_const.dart';
import 'package:deepak_machine_test/services/model/ProfileDetailModel.dart';
import 'package:deepak_machine_test/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  String? token;
  ProfileDetailModel? profile;

  bool loginLoading = false;

  changeLoginLoading(bool status) {
    loginLoading = status;
    notifyListeners();
  }

  //User Login
  userLogin(context, {required String email, required String password}) async {
    changeLoginLoading(true);
    ApiHelper apiHelper = ApiHelper(url: ApiUrl().loginUrl);
    Map<String, String> body = {"email": email, "password": password};
    var response = await apiHelper.post(body);
    if (response["token"] != null) {
      changeLoginLoading(false);
      token = response["token"];
      bool done = await saveTokenToLocal(token: token!);
      if (done) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (route) => false);
      } else {
        changeLoginLoading(false);
        showToast(msg: "Something went wrong , Please Try Again");
      }
    } else if (response["error"] != null) {
      changeLoginLoading(false);
      showToast(msg: response["error"]);
    } else {
      changeLoginLoading(false);
      showToast(msg: "Something went wrong");
    }
  }

  //Single profile details
  //Api issue so i have passed userid
  profileDetails() async {
    ApiHelper apiHelper = ApiHelper(url: "${ApiUrl().profileUrl}/2");
    var response = await apiHelper.get();
    if (response.isNotEmpty) {
      profile = ProfileDetailModel.fromJson(response);
      notifyListeners();
    } else {
      showToast(msg: "Profile Details Not Found");
    }
  }

  //save token to local
  Future<bool> saveTokenToLocal({required String token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('token', token);
  }

  //get token from local
  Future<String> getTokenFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString('token') ?? "";
    token = action;
    return action;
  }

  //logout user
  logoutUser(context) async {
    bool done = await saveTokenToLocal(token: "");
    if (done) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  //Firebase Section
  googleLogin(context) async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      showToast(msg: googleSignInAccount!.displayName.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
          (route) => false);
    } catch (error) {
      print(error.toString() + "??????????");
    }
  }
}
