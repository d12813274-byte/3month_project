import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month3/database/app_database.dart';
import 'package:flutter_month3/database/app_repository.dart';
import 'package:flutter_month3/home/home_page.dart';
import 'package:flutter_month3/settings/settings_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_month3/onboarding/onboarding_page.dart';


late final AppDatabase appDatabase;
late final AppRepositoryImpl appRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   final prefs = await SharedPreferences.getInstance();
  final isOnboardingViewed = prefs.getBool("isOnboardingViewed") ?? false;

  await Hive.initFlutter();
  await Hive.openBox("todoBox");

    appDatabase = AppDatabase();
  appRepository = AppRepositoryImpl(db: appDatabase);

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
    return BlocBuilder<SettingsCubit, bool>(
      builder: (context, isDark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do List',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF007AFF),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: isOnboardingViewed
              ? const MyHomePage(title: "Мои задачи")
              : const OnboardingPage(),
        );
      },
    );
  }
}