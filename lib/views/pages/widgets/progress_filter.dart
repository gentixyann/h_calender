import 'package:flutter/material.dart';

class ProgressFilter extends StatelessWidget {
  const ProgressFilter({
    super.key,
    required this.isInProgress,
    required this.child,
  });

  final bool isInProgress;
  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          if (isInProgress)
            Positioned.fill(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
}
