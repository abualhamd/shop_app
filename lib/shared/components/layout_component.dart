import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class LayoutComponent extends StatelessWidget {
  const LayoutComponent({
    super.key,
    required this.condition,
    required this.child,
  });

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConditionalBuilder(
          //TODO might need to change condition
          condition: condition,
          builder: (context) => child,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
