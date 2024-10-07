class ErrorWithMessage extends Error {
  ErrorWithMessage(this.message);
  final String message;
  @override
  String toString() => message;
}

final unknownError = ErrorWithMessage('エラーが発生しました');

typedef OnError = void Function(ErrorWithMessage error);
