import 'package:flutter/material.dart';

class UnFocus extends StatelessWidget {
  const UnFocus({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          currentScope.unfocus();
        }
      },
      child: child,
    );
  }
}
