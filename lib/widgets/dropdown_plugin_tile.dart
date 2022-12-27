import 'package:flutter/material.dart';

class DropdownPlugin extends StatefulWidget {
  const DropdownPlugin({super.key});

  @override
  State<DropdownPlugin> createState() => _DropdownPluginState();
}

class _DropdownPluginState extends State<DropdownPlugin> {
  int v1 = 1;
  int v2 = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
                child: DropdownButton(
                    isExpanded: true,
                    value: v1,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Item 1'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Item 2'),
                      ),
                    ],
                    onChanged: (p) => setState(() {
                          v1 = p ?? 1;
                        })))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 6),
                child: DropdownButton(
                    isExpanded: true,
                    value: v2,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Item 1'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Item 2'),
                      ),
                    ],
                    onChanged: (p) => setState(() {
                          v2 = p ?? 1;
                        }))))
      ],
    );
  }
}
