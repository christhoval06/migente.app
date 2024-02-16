import 'package:flutter/material.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/models/option.dart';

class OptionRepo {
  static List<Option> getOptions() {
    final List<Option> options = [
      Option(
          id: "new-people",
          name: "Agregar persona",
          icon: Icons.add,
          path: RoutePaths.addPerson),
      Option(
          id: "search-people",
          name: "Busqueda",
          icon: Icons.search,
          path: RoutePaths.list),
      Option(
          id: "admin-stats",
          name: "Administración",
          icon: Icons.settings,
          path: RoutePaths.code),
    ];

    return options;
  }
}
