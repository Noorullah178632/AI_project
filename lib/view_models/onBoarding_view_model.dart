import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingProvider = NotifierProvider<OnboardingViewModel, int>(
  OnboardingViewModel.new,
);

class OnboardingViewModel extends Notifier<int> {
  //it will set value to 0 in inital state : state=0
  @override
  int build() => 0;
  //setPage
  void setPage(int index) {
    state = index;
  }

  //next : totalpage and pageController for animation
  void nextPage(int totalPage, PageController controller) {
    if (state < totalPage - 1) {
      state++;
      //animate the navigation
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  //previoue : pageController for animation
  void previousPage(PageController controller) {
    if (state > 0) {
      state--;
      //animate the navigation
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  //skip
  void skipPage(int lastIndex, PageController controller) {
    state = lastIndex;
    //animation
    controller.jumpToPage(lastIndex);
  }
}
