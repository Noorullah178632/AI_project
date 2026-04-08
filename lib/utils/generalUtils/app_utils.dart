import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static void showToastMessage(String message, {Color? bgColor}) {
    try {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor ?? Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 16.sp,
      );
    } catch (e) {
      debugPrint("Toast Error $e");
    }
  }

  //use snack bar for web
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? color,
  }) {
    // This clears any existing snackbars so they don't stack up
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 14.sp)),
        backgroundColor: color ?? Colors.lightBlue,
        behavior: SnackBarBehavior.floating, // Makes it look modern/floating
        width: 250
            .w, // Controls width so it doesn't stretch across the whole web screen
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
