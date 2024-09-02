import 'package:flutter/material.dart';
import 'package:h_calender/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_calender/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  MyApp.run();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '性活カレンダー',
      routerConfig: router,
      theme: AppTheme.lightTheme,
    );
  }

  static Future<void> run() async {
    await initializeDateFormatting('ja_JP').then((_) {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const ProviderScope(
        child: MyApp(),
      ));
    });
  }
}
