import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yin_yang/pages/home.dart';

import 'settings.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.title});

  final String title;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool loading = true;
  var shell = Shell();

  final List<Tab> _tabs = [
    Tab(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.schedule), Text('Schedule')])),
    Tab(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.settings), Text('Settings')]))
  ];

  @override
  void initState() {
    super.initState();
    shell.run('sh lib/scripts/getOS.sh').then((env) {
      SharedPreferences.getInstance().then((prefs) {
        String desktop = '';

        if (env.outText.contains('KDE') ||
            env.outText.contains('plasma') ||
            env.outText.contains('plasma5')) {
          desktop = 'KDE';
        }
        if (env.outText.contains('gnome')) {
          desktop = 'gnome';
        }
        if (env.outText.contains('budgie')) {
          desktop = 'budgie';
        }
        if (env.outText.contains('xfce')) {
          desktop = 'xfce';
        }
        prefs.setString('desktop', desktop);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
                bottom: TabBar(
                  tabs: _tabs,
                )),
            body: const TabBarView(children: [Home(), Settings()])));
  }
}
