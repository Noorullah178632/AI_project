import 'package:ai_project/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = Provider((ref) => SplashViewModel());

class SplashViewModel {
  // 2. Access the Service
  final _service = SplashService();

  void startApp(BuildContext context) {
    _service.userFirstTime(context);
  }
}
