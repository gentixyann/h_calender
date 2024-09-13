String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'メールアドレスを入力してください';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'パスワードを入力してください';
  }
  return null;
}
