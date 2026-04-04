import 'package:ai_project/view_models/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(splashProvider).startApp(context);
    });
    return const Scaffold(body: Center(child: Text("Splash Screen Data ")));
  }
}
