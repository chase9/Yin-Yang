import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yin_yang/widgets/dropdown_plugin_tile.dart';
import 'package:yin_yang/widgets/kde_settings.dart';
import 'package:yin_yang/widgets/plugin_tile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String desktop = '';

  final List<Widget> _plugins = [const KDESettings()];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        desktop = prefs.getString('desktop') ?? 'KDE';
      });
    });
  }

  Widget _buildPluginList() {
    return ListView(
      padding: EdgeInsets.all(6.0),
      children: _plugins,
    );
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
    return _buildPluginList();
  }
}
