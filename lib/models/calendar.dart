import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final focusedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
