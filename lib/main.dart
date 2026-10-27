import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/home/home_page.dart';
import 'package:flutter_month3/settings/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_month3/onboarding/onboarding_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isOnboardingViewed = prefs.getBool("isOnboardingViewed") ?? false;
  runApp(
    BlocProvider(
      create: (_) => SettingsCubit(),
      child: MyApp(isOnboardingViewed: isOnboardingViewed),
    ),
  );
}

class MyApp extends StatelessWidget {
 final bool isOnboardingViewed;
 const MyApp({super.key, required this.isOnboardingViewed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF007AFF),
        scaffoldBackgroundColor: Colors.white,
      ),
     home: isOnboardingViewed 
     ? const MyHomePage(title: "Мои задачи") : const OnboardingPage(),
    );
  }
}