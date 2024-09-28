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

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '名前を入力してください';
  }
  return null;
}
