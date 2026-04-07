import 'package:ai_project/utils/images/app_images.dart';
import 'package:ai_project/view_models/onBoarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // This shows the Skip button ONLY on page 0 and page 1
          currentPage < 2
              ? Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(onBoardingProvider.notifier)
                          .skipPage(pageImages.length - 1, pageController);
                    },
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 225, 185, 198),
                              Colors.lightBlue,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {},
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 225, 185, 198),
                              Colors.lightBlue,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
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
              padding: EdgeInsets.only(bottom: 30.h),
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  currentPage > 0
                      ? GestureDetector(
                          onTap: () {
                            ref
                                .read(onBoardingProvider.notifier)
                                .previousPage(pageController);
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
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

                    onDotClicked: (index) {
                      // 1. Update the state in your Notifier
                      ref.read(onBoardingProvider.notifier).setPage(index);

                      // 2. Animate the PageView to the new index
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  currentPage < 2
                      ? GestureDetector(
                          onTap: () {
                            ref
                                .read(onBoardingProvider.notifier)
                                .nextPage(
                                  pageImages.length + 1,
                                  pageController,
                                );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
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
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
