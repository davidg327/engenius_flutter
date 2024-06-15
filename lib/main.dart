import 'package:flutter/material.dart';
import 'package:test_flutter/screens/unknown_route_screen.dart';
import '../routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const UnknownRouteScreen(),
        );
      },
    );
  }
}
