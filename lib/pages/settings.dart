import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yin_yang/widgets/kde_settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String desktop = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        desktop = prefs.getString('desktop') ?? 'KDE';
      });
    });
  }

  Widget buildDesktopSettings() {
    switch (desktop) {
      case 'KDE':
        return const KDESettings();
      case 'gnome':
        return const KDESettings();
    }
    return const KDESettings();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[buildDesktopSettings()],
    );
  }
}
