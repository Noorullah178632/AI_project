import 'package:ai_project/utils/images/app_images.dart';
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
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Image(
          image: AssetImage(AppImages.splashLogo),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
