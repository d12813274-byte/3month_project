import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_month3/home/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Future<void> _saveOnboardingViewed () async {
final prefs = await
  SharedPreferences.getInstance();
  await prefs.setBool("isOnboardingViewed", true);
  }
  @override
  void initState() {
    super.initState();
    _saveOnboardingViewed();
  }
  void _onStartTap() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MyHomePage(title: "Мои задачи"),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Все важное - по дням"),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onStartTap,
               child: const Text("Начать"),
               )
          ],
        ),
      ),
    );
  }
}