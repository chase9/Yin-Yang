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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20),
                child: TextButton.icon(
                  label: const Text(
                    'back',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                      alignment: Alignment.centerRight),
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.arrow_back),
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildDesktopSettings()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
