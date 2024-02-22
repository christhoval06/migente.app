import 'package:flutter/material.dart';

class RenderIfView extends StatelessWidget {
  final Widget Function() render;
  final Widget replacement;
  final bool condition;

  const RenderIfView({
    super.key,
    required this.condition,
    required this.render,
    this.replacement = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return condition ? render() : replacement;
  }
}
