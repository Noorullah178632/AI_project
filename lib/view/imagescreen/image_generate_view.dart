import 'package:ai_project/models/image_ai_models.dart';

import 'package:ai_project/view/imagescreen/widgets/imageBubble.dart';
import 'package:ai_project/view/imagescreen/widgets/textBubble.dart';
import 'package:ai_project/view_models/image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGenerateView extends ConsumerWidget {
  ImageGenerateView({super.key});
  final textControllerProvider = Provider<TextEditingController>((ref) {
    final controller = TextEditingController();
    //make a dispose method
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get all the riverpods
    final textController = ref.watch(textControllerProvider);
    final dataList = ref.watch(ImageViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue,
                Color(0xFFE1B9C6), // Pink (70% dominance)
                // Blue (30% accent)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.7, 1.0],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.brush_outlined,
                color: Colors.white,
                size: 20.w,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              "AI Image Gen",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final data = dataList[index];
                  return Align(
                    alignment: data.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: data.type == MessageType.text
                        ? textBubble(context, data)
                        : imageBubble(context, data),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,

                border: Border(
                  top: BorderSide(color: Colors.white10, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  // 1. The Input Field
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TextField(
                        controller: textController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Ask anything...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                        //onsubmitted for "Enter" Button
                        onSubmitted: (value) {
                          final message = textController.text.trim();
                          if (message.isNotEmpty) {
                            ref
                                .read(ImageViewModelProvider.notifier)
                                .sendMessage(message);
                          }
                          textController.clear();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // 2. The Send Button
                  GestureDetector(
                    onTap: () {
                      final message = textController.text.trim();
                      if (message.isNotEmpty) {
                        ref
                            .read(ImageViewModelProvider.notifier)
                            .sendMessage(message);
                      }
                      textController.clear();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue,
                            Color(0xFFE1B9C6),
                          ], // Theme consistency
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
