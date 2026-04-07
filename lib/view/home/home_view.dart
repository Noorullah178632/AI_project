import 'package:ai_project/utils/routes/route_name.dart';
import 'package:ai_project/view/home/widgets/feature_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with Greeting
              SizedBox(height: 20.h),
              Text(
                "Hello, Noor",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "What would you like to create today?",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),

              SizedBox(height: 40.h),

              // 2. Feature Cards
              FeatureCard(
                title: "AI Chat Assistant",
                desc: "Smart conversations & task solving",
                icon: Icons.chat_bubble_rounded,
                gradient: [Colors.blue, Colors.lightBlueAccent],
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.chatScreen);
                }, // Using GoRouter or Navigator
              ),

              SizedBox(height: 20.h),

              FeatureCard(
                title: "AI Image Generator",
                desc: "Turn your text into stunning art",
                icon: Icons.image_rounded,
                gradient: [
                  const Color.fromARGB(255, 196, 52, 97),
                  Colors.pinkAccent,
                ],
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.imageGenScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
