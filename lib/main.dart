import 'package:flutter/material.dart';
import 'package:yin_yang/pages/layout.dart';
import 'package:yin_yang/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:yin_yang/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: const Layout(title: 'Yin-Yang'),
    );
  }
}
