import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/settings/settings_cubit.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<SettingsCubit, bool>(
    builder: (context, isDark) {
      return
    Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text("Настройки"),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black87 : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Тёмная тема",
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            Switch(
              value: isDark,
              onChanged: (value) {
                context.read<SettingsCubit>().toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
    },
   );
  }
}