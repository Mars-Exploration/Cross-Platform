import 'package:flutter/material.dart';
import 'package:reddit/presentation/screens/home.dart';

class AppRouter {
  // declare repository and cubit objects
  AppRouter() {
    // initialise repository and cubit objects
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      /*
      case example:
      case '/':
        return MaterialPageRoute(
          // create bloc at the the root of widget tree
          builder: (_) => BlocProvider(
            // we pass the cubit class to create
            create: (context) => CubitObject,
            // our child is the screen itself
            child: const Screen(),
          ),
        );
      */
      default:
        return null;
    }
  }
}
