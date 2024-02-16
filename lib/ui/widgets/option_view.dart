import 'package:flutter/material.dart';
import 'package:mi_gente/models/option.dart';

class OptionView extends StatelessWidget {
  final Option option;

  const OptionView({super.key, required this.option});

  openPage(BuildContext context, Option option) {
    Navigator.pushNamed(context, option.path);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        openPage(context, option);
      },
      icon: Icon(option.icon, color: Colors.white70, size: 48.0),
      label: Text(
        option.name,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 4.0,
          animationDuration: const Duration(milliseconds: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}
