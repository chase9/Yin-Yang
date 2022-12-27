import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yin_yang/widgets/dropdown_plugin_tile.dart';
import 'package:yin_yang/widgets/plugin_tile.dart';

class KDESettings extends StatefulWidget {
  const KDESettings({super.key});

  @override
  State<KDESettings> createState() => _KDESettingsState();
}

class _KDESettingsState extends State<KDESettings> {
  bool isEnabled = false;
  final String _pluginKey = 'kdeEnabled';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        isEnabled = prefs.getBool('kdeEnabled') ?? false;
      });
    });
  }

  void setEnabled(bool? isEnabled) {
    if (isEnabled == null) {
      return;
    }

    setState(() {
      isEnabled = isEnabled;
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_pluginKey, isEnabled!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PluginContainer(
        title: 'KDE Plugin',
        pluginKey: _pluginKey,
        plugin: const DropdownPlugin());
  }
}
