import 'package:ai_project/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnboardingView extends ConsumerWidget {
  OnboardingView({super.key});
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
    //watch data
    final pageController = ref.watch(pageControllerProvider);
    // final currentPage = ref.watch(onBoardingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("OnBoarding Screen "),
      ),
      body: Stack(
        children: [
          //pageview
          PageView.builder(
            controller: pageController,
            itemCount: pageImages.length,
            onPageChanged: (value) {},
            itemBuilder: (context, index) {
              return SizedBox.expand(
                // Ensures the image container is full screen
                child: Image.asset(
                  pageImages[index], // Assuming pageImages is a list of Strings (paths)
                  fit: BoxFit
                      .cover, // This is the key to covering the whole screen
                ),
              );
            },
          ),
          //smoothpageIndicator
          Align(
            alignment: .bottomCenter,

            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: SmoothPageIndicator(
                controller: pageController,
                count: pageImages.length,
                axisDirection: .horizontal,

                onDotClicked: (index) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
