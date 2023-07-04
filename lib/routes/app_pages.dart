import 'package:flutter/cupertino.dart';
import 'package:muhamadagussupriyantono_elisoft_technology/pages/ui/dashboard/dashboard_page.dart';
import 'package:muhamadagussupriyantono_elisoft_technology/pages/ui/login/login_page.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    // final arguments =
    //     (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

    return CupertinoPageRoute<dynamic>(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case Routes.LOGIN:
            return const LoginPage();
          case Routes.DASHBOARD:
            return const DashBoardPage();
          default:
            return const LoginPage();
        }
      },
    );
  }
}
