import 'package:flutter/material.dart';
import 'package:yin_yang/event_dispatcher.dart';
import 'package:yin_yang/theme/theme_notifier.dart';
import 'package:yin_yang/theme/theme.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  RangeValues values = const RangeValues(1, 23);
  RangeLabels labels = const RangeLabels('1', "23");
  bool _themeIsDark = false;
  bool _isScheduled = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 0.5);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Yin-Yang Logo
            RotationTransition(
              turns: _animation,
              child: Image.asset(
                'resources/logo128.png',
                width: 128.0,
                height: 128.0,
                fit: BoxFit.cover,
              ),
            ),
            // Theme switch buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: _themeIsDark
                      ? () {
                          _controller.reverse();

                          switchToLight();
                          setState(() {
                            _themeIsDark = !_themeIsDark;
                          });
                          Provider.of<ThemeNotifier>(context, listen: false)
                              .setTheme(lightTheme, false);
                        }
                      : null,
                  style: OutlinedButton.styleFrom(
                      foregroundColor:
                          _themeIsDark ? Colors.white : Colors.black,
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  child: const Text('Light'),
                ),
                OutlinedButton(
                    onPressed: _themeIsDark
                        ? null
                        : () {
                            _controller.forward();
                            switchToDark();
                            setState(() {
                              _themeIsDark = !_themeIsDark;
                            });
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setTheme(darkTheme, true);
                          },
                    style: OutlinedButton.styleFrom(
                        foregroundColor:
                            _themeIsDark ? Colors.white : Colors.black,
                        padding: const EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    child: const Text('Dark'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CheckboxListTile(
                    activeColor: Colors.black,
                    title: const Text("scheduled"),
                    value: _isScheduled,
                    onChanged: (newValue) {
                      setState(() {
                        _isScheduled = !_isScheduled;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "${labels.start} - ${labels.end}",
                    style: const TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                  thumbColor: _themeIsDark ? Colors.white : Colors.black,
                  activeTrackColor: Colors.grey[300],
                  inactiveTrackColor: Colors.black),
              child: RangeSlider(
                  min: 1,
                  max: 23,
                  divisions: 48,
                  values: values,
                  onChanged: _isScheduled
                      ? (v) {
                          String startLabel =
                              v.start % v.start.round() < 1 ? "30" : "00";
                          String endLabel =
                              v.end % v.end.round() < 1 ? "30" : "00";
                          setState(() {
                            values = v;
                            labels = RangeLabels(
                                "${(v.start).toInt().toString()}:$startLabel",
                                "${(v.end).toInt().toString()}:$endLabel");
                          });
                        }
                      : null),
            ),
          ],
        ));
  }
}
