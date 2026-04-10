import 'package:ai_project/utils/generalUtils/app_utils.dart';
import 'package:ai_project/view/chatscreen/widgets/text_controller_providers.dart';
import 'package:ai_project/view_models/chat_message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreenView extends ConsumerWidget {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get the chat provider for Textediting controller
    final chatController = ref.watch(chatControllerProvider);
    //get the chatMessageViewModel list
    final messageProvider = ref.watch(chatmessageProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
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
                Icons.smart_toy_outlined,
                color: Colors.white,
                size: 20.w,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              "AI Chat",
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
                itemCount: messageProvider.length,
                itemBuilder: (context, index) {
                  final message = messageProvider[index];
                  // logic even : user and odd : AI
                  bool isUser = index % 2 == 0;

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width:
                          240.w, // Increased width for better text readability
                      margin: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        // Blue for User (80% theme), Green/Grey for AI
                        color: isUser
                            ? Colors.blue.shade700
                            : Colors.grey.shade800,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                          bottomLeft: isUser
                              ? Radius.circular(16.r)
                              : Radius.zero,
                          bottomRight: isUser
                              ? Radius.zero
                              : Radius.circular(16.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
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
                                  await Clipboard.setData(
                                    ClipboardData(text: message.text),
                                  );
                                  if (context.mounted) {
                                    AppUtils.showSnackBar(
                                      context,
                                      "Text Copied!",
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
                                  message.formattedDate.toString(),
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
                        controller: chatController,
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
                          final message = chatController.text.trim();
                          if (message.isNotEmpty) {
                            ref
                                .read(chatmessageProvider.notifier)
                                .sendMessage(message);
                            //clear chat
                            chatController.clear();
                            //unfocus the field
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // 2. The Send Button
                  GestureDetector(
                    onTap: () {
                      final message = chatController.text.trim();
                      if (message.isNotEmpty) {
                        ref
                            .read(chatmessageProvider.notifier)
                            .sendMessage(message);
                      }
                      //clear the text
                      chatController.clear();
                      //unfocus the text

                      FocusScope.of(context).unfocus();
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
