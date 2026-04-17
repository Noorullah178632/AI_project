import 'package:ai_project/services/download_image_service.dart';
import 'package:ai_project/utils/generalUtils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGenerateView extends ConsumerWidget {
  const ImageGenerateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: EdgeInsets.symmetric(vertical: 5.h),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final image = "this is image ";
                  // logic even : user and odd : AI
                  bool isUser = index % 2 == 0;

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: isUser
                        ? Container(
                            width: 240
                                .w, // Increased width for better text readability

                            margin: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              // Blue for User (80% theme), Green/Grey for AI
                              color: Colors.blue.shade700,

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                                bottomLeft: Radius.circular(16.r),

                                bottomRight: Radius.zero,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "this ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                // Tiny Copy Button
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Clipboard.setData(
                                          ClipboardData(text: image),
                                        );
                                        if (context.mounted) {
                                          AppUtils.showSnackBar(
                                            context,
                                            "Text copied",
                                          );
                                        }
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.copy,
                                          size: 14.w,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                    //SizedBox(height: 8.h),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "11:40 AM",
                                        style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20.r,
                                          //  fontWeight: .bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: 1.sw,
                            height: 200.h,
                            margin: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5.w,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // 1. The Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    "https://tinyurl.com/yz5t6pax",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                          strokeWidth: 2.w,
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            ),
                                  ),
                                ),

                                // 2. Download Button Overlay
                                Align(
                                  alignment: .bottomEnd,
                                  child: GestureDetector(
                                    onTap: () {
                                      DownloadImageService()
                                          .downloadImage(
                                            "https://tinyurl.com/yz5t6pax",
                                          )
                                          .then((value) {
                                            AppUtils.showSnackBar(
                                              context,
                                              "Image Downloaded",
                                            );
                                          });
                                      if (context.mounted) {}
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        //   color: Colors.blue.withOpacity(0.6),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.lightBlue,
                                            Color(0xFFE1B9C6),
                                          ],
                                          begin: .centerLeft,
                                          end: .centerRight,
                                          stops: [0.2, 1.0],
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
                          ),
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
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // 2. The Send Button
                  GestureDetector(
                    onTap: () {},
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
