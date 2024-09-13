import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/database/shared_preferences.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/intro/view/intro_screen.dart';
import 'package:sen/features/parent_home/view/parent_home_screen.dart';
import 'package:sen/features/teacher_home/view/teacher_home_screen.dart';
import 'package:sen/features/therapist_home/view/therapist_home_screen.dart';
import 'package:sen/utils/app_colors.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA7vhbDPJrodnCgxp576tvIgs4PGUW38-s",
      appId: "1:212046817970:android:3cc0f7c0ab71cc65ca77ab",
      messagingSenderId: "212046817970",
      projectId: "senkids-c5865",
      storageBucket: "senkids-c5865.appspot.com",
    ),
  );
  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => AppManagerCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.background,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          home: homeScreen(),
        ),
      ),
    );
  }

  Widget homeScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      return const IntroScreen();
    } else {
      if (PreferenceUtils.getString(PrefKeys.userType) == 'parent') {
        return const ParentHomeScreen();
      } else if (PreferenceUtils.getString(PrefKeys.userType) == 'teacher') {
        return const TeacherHomeScreen();
      } else if (PreferenceUtils.getString(PrefKeys.userType) == 'therapist') {
        return const TherapistHomeScreen();
      } else {
        return const IntroScreen();
      }
    }
  }
}
