import 'package:ai_project/utils/routes/route_name.dart';
import 'package:flutter/material.dart';

class SplashService {
  void userFirstTime(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesName.onBoardindScreen);
    });
  }
}
