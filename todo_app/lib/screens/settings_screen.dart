import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Provider.of<ThemeProvider>(context).isLight
                        ? "Aydınlık Tema"
                        : "Karanlık Tema",
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                    activeColor: Theme.of(context).hintColor,
                    activeTrackColor: Theme.of(context).dividerColor,
                    inactiveThumbColor: Theme.of(context).hintColor,
                    inactiveTrackColor: Theme.of(context).dividerColor,
                    splashRadius: 50.0,
                    value: Provider.of<ThemeProvider>(context).isLight,
                    onChanged: (_) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toogleTheme();
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
