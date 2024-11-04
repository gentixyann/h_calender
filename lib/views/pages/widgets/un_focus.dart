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
        // 現在のフォーカス情報を取得
        final currentScope = FocusScope.of(context);
        // hasPrimaryFocusがfalseで、かつhasFocusがtrueであれば、現在何らかのウィジェットがフォーカスを持っていると判定
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          // TextFieldなどに設定されているフォーカスが解除され、キーボードが閉じる
          currentScope.unfocus();
        }
      },
      child: child,
    );
  }
}
