import 'package:flutter/material.dart';
import 'package:mi_gente/code_page.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/home_page.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/people_page.dart';
import 'package:mi_gente/person_form.dart';
import 'package:mi_gente/qr_scanner.dart';
import 'package:mi_gente/stats_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RoutePaths.list:
        return MaterialPageRoute(builder: (_) => const PeoplePage());
      case RoutePaths.addPerson:
        return MaterialPageRoute(builder: (_) => PersonForm(isNew: true));
      case RoutePaths.updatePerson:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final Person person = arguments['person'] as Person;
        return MaterialPageRoute(
            builder: (_) => PersonForm(isNew: false, person: person));
      case RoutePaths.code:
        Person? person;
        String route = RoutePaths.stats;

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;

          if (arguments.containsKey('person')) {
            person = arguments['person'] as Person;
          }

          if (arguments.containsKey('route')) {
            route = arguments['route'] as String;
          }
        }

        return MaterialPageRoute(
            builder: (_) => CodePage(
                  route: route,
                  person: person,
                ));
      case RoutePaths.stats:
        return MaterialPageRoute(builder: (_) => StatsPage());
      case RoutePaths.qrCode:
        return MaterialPageRoute(builder: (_) => QrScannerPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
// https://stackoverflow.com/questions/59822279/difference-between-ongenerateroute-and-routes-in-flutter
