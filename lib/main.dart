import 'package:api_project/utils/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ITG Consume API',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      routeInformationParser: AppRouter.goRouter.routeInformationParser,
      routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
      routerDelegate: AppRouter.goRouter.routerDelegate,
    );
  }
}
