import 'package:ai_project/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});
  //provider for page Controller
  final pageControllerProvider = Provider((ref) {
    return PageController();
  });
  //make list of images to show on Onboarding Screen
  List<String> pageImages = [
    AppImages.humanLogo,
    AppImages.chatPic,
    AppImages.imagePic,
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: AppBar(), body: PageView());
  }
}
