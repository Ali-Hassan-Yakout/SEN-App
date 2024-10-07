import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/settings/view/settings_screen.dart';
import 'package:sen/features/teacher_home/manager/teacher_home_cubit.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final cubit = TeacherHomeCubit();

  @override
  Widget build(BuildContext context) {
    List<String> appBarTitles = [
      S.of(context).subjects,
      S.of(context).quizzes,
      S.of(context).grades,
      S.of(context).reports,
    ];
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ScreenChange,
            builder: (context, state) {
              return Text(
                appBarTitles[cubit.pageIndex],
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.mainFont,
                ),
              );
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                size: 40.r,
                color: AppColors.primaryBackground,
              ),
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: AppColors.primaryBackground,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            cubit.pageIndex = index;
            BlocProvider.of<AppManagerCubit>(context).onScreenChange();
          },
          items: [
            Icon(
              Icons.play_lesson_rounded,
              size: 40.r,
              color: Colors.white,
            ),
            Icon(
              Icons.quiz_rounded,
              size: 40.r,
              color: Colors.white,
            ),
            Icon(
              Icons.grade,
              size: 40.r,
              color: Colors.white,
            ),
            Icon(
              Icons.contact_page_sharp,
              size: 40.r,
              color: Colors.white,
            ),
          ],
        ),
        body: BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) => current is ScreenChange,
          builder: (context, state) => cubit.pages[cubit.pageIndex],
        ),
      ),
    );
  }
}
