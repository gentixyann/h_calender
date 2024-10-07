import 'package:flutter/material.dart';

class CommonSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final SnackBarBehavior behavior;
  final int durationSeconds;

  const CommonSnackBar({
    super.key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.behavior = SnackBarBehavior.fixed,
    this.durationSeconds = 3,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox
        .shrink(); // 実際にはScaffoldMessengerで表示されるため、ここではUIの要素は不要
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    int durationSeconds = 3,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: behavior,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        duration: Duration(seconds: durationSeconds),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(message),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
