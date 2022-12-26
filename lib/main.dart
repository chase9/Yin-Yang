import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:yin_yang/pages/splash.dart';
import 'package:yin_yang/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:yin_yang/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Yin-Yang Auto Night Mode');
    setWindowMinSize(const Size(400, 550));
    setWindowMaxSize(const Size(400, 550));
  }

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(darkTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Yin-Yang',
      theme: themeNotifier.getTheme(),
      home: const RouteSplash(),
    );
  }
}
