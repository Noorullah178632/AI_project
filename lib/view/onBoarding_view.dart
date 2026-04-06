import 'package:ai_project/utils/images/app_images.dart';
import 'package:ai_project/view_models/onBoarding_view_model.dart';
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
    final currentPage = ref.watch(onBoardingProvider);

    return Scaffold(
      //  backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, actions: [
   
   ],
      ),
      body: Stack(
        children: [
          //pageview
          PageView.builder(
            controller: pageController,
            itemCount: pageImages.length,
            onPageChanged: (value) {
              ref.read(onBoardingProvider.notifier).setPage(value);
            },
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
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  currentPage > 0
                      ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 225, 185, 198),
                                  Colors.lightBlue,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: pageImages.length,
                    axisDirection: .horizontal,

                    onDotClicked: (index) {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 225, 185, 198),
                            Colors.lightBlue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
