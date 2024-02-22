import 'package:flutter/material.dart';
import 'package:mi_gente/models/option.dart';
import 'package:mi_gente/repository/option_repo.dart';
import 'package:mi_gente/ui/widgets/option_view.dart';

class MainPage extends StatelessWidget {
  final List<Option> options = OptionRepo.getOptions();

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Mi Gente"),
      ),
      body: Center(
          child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 150),
              itemCount: options.length,
              itemBuilder: (BuildContext ctx, index) {
                final Option option = options[index];
                return OptionView(option: option);
              })),
    );
  }
}
