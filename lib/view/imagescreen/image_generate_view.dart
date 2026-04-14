import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGenerateView extends ConsumerWidget {
  const ImageGenerateView({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
