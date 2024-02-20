import 'package:flutter/material.dart';

class RenderIfView extends StatelessWidget {
  final Widget child;
  final Widget replacement;
  final bool condition;

  const RenderIfView({
    super.key,
    required this.condition,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return condition ? child : replacement;
  }
}
