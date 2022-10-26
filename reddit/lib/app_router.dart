import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/account_settings_screen.dart';

class AppRouter {
  // declare repository and cubit objects
  AppRouter() {
    // initialise repository and cubit objects
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: Container(),
                ));
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
      case accountSettingsRoute:
        return MaterialPageRoute(builder: (_) => AccountSettingsScreen());
      case updateEmailAddressRoute:
        return MaterialPageRoute(builder: (_) => UpdateEmailAddressScreen());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => changePasswordScreen());
      default:
        return null;
    }
  }
}
