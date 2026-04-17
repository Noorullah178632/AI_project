import 'package:ai_project/models/image_ai_models.dart';
import 'package:ai_project/utils/generalUtils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textBubble(BuildContext context, ImageAiModels data) {
  return Container(
    width: 240.w,
    margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.blue.shade700, // ✅ same for both
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
        bottomLeft: Radius.circular(16.r),
        bottomRight: data.isUser
            ? Radius.zero
            : Radius.circular(16.r), // only alignment difference
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  Text
        Text(
          data.text ?? "",
          style: TextStyle(
            color: Colors.white, // ✅ same text color
            fontSize: 14.sp,
          ),
        ),

        SizedBox(height: 8.h),

        // 🔧 Actions row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 📋 Copy
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.text ?? ""));

                if (context.mounted) {
                  AppUtils.showSnackBar(context, "Text copied");
                }
              },
              child: Icon(Icons.copy, size: 14.w, color: Colors.white54),
            ),

            // 🕒 Time
            Text(
              data.formattedTime,
              style: TextStyle(color: Colors.white70, fontSize: 10.sp),
            ),
          ],
        ),
      ],
    ),
  );
}
