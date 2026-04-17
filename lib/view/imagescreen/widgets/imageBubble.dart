import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_project/models/image_ai_models.dart';
import 'package:ai_project/services/download_image_service.dart';
import 'package:ai_project/utils/generalUtils/app_utils.dart';

Widget imageBubble(BuildContext context, ImageAiModels data) {
  final imageUrl = data.image;
  if (imageUrl == null || imageUrl.isEmpty) {
    return const Center(child: Icon(Icons.broken_image));
  }
  final bytes = base64Decode(imageUrl);
  return Container(
    width: 1.sw,
    height: 200.h,
    margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade300, width: 1.5.w),
    ),
    child: Stack(
      children: [
        //  Image
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,

            errorBuilder: (_, __, ___) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),

        // ⬇ Download Button
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () async {
              try {
                await DownloadImageService().downloadImage(imageUrl);

                if (context.mounted) {
                  AppUtils.showSnackBar(context, "Image Downloaded");
                }
              } catch (e) {
                if (context.mounted) {
                  AppUtils.showSnackBar(context, "Download Failed");
                }
              }
            },
            child: Container(
              margin: EdgeInsets.all(8.w),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.lightBlue, Color(0xFFE1B9C6)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.file_download_outlined,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
