import 'package:flutter/material.dart';
import 'package:h_calender/firebase_options.dart';
import 'package:h_calender/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_calender/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ja_JP').then((_) {
    runApp(const ProviderScope(
      child: MyApp(),
    ));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: '性活カレンダー',
      routerConfig: router,
      theme: AppTheme.lightTheme,
    );
  }
}
