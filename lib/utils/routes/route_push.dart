import 'package:ai_project/utils/routes/route_name.dart';
import 'package:ai_project/view/chat_screen_view.dart';
import 'package:ai_project/view/home_view.dart';
import 'package:ai_project/view/image_generate_view.dart';
import 'package:ai_project/view/splash_view.dart';
import 'package:flutter/material.dart';

class RoutePush {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.chatScreen:
        return MaterialPageRoute(builder: (_) => ChatScreenView());
      case RoutesName.imageGenScreen:
        return MaterialPageRoute(builder: (_) => ImageGenerateView());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
