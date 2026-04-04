import 'package:ai_project/utils/routes/route_name.dart';
import 'package:ai_project/utils/routes/route_push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AI Application',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: RoutesName.splash,
      onGenerateRoute: RoutePush.generateRoute,
    );
  }
}
