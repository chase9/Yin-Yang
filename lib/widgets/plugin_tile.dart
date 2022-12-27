import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef CheckCallbackType = void Function(bool?);

class PluginContainer extends StatefulWidget {
  const PluginContainer(
      {super.key,
      required this.title,
      required this.pluginKey,
      this.isEnabledCallback,
      required this.plugin});

  final String title;
  final String pluginKey;
  final CheckCallbackType? isEnabledCallback;
  // TODO: Actually check types
  final Widget plugin;

  @override
  State<PluginContainer> createState() => _PluginContainerState();
}

class _PluginContainerState extends State<PluginContainer> {
  late final SharedPreferences _prefs;
  bool _pluginEnabled = false;
  late String _pluginLight;
  late String _pluginDark;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      _pluginEnabled = _prefs.getBool(widget.pluginKey) ?? true;
      _pluginLight = _prefs.getString(widget.pluginKey) ?? "";
      _pluginDark = _prefs.getString(widget.pluginKey) ?? "";
    });
  }

  _setEnabledState(bool isEnabled) {
    setState(() {
      _pluginEnabled = isEnabled;
    });
    _prefs.setBool(widget.pluginKey, isEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Column(
          children: [
            CheckboxListTile(
              value: _pluginEnabled,
              onChanged: (value) {
                _setEnabledState(value ?? false);
                if (widget.isEnabledCallback != null) {
                  widget.isEnabledCallback!(value);
                }
              },
              title: Text(widget.title),
            ),
            widget.plugin
          ],
        ));
  }
}
