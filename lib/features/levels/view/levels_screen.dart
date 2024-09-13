import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_grades/view/all_grades_screen.dart';
import 'package:sen/features/all_lessons/view/all_lessons_screen.dart';
import 'package:sen/features/all_quizzes/view/all_quizzes_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class LevelsScreen extends StatelessWidget {
  final String screen;
  final String subject;

  const LevelsScreen({
    super.key,
    required this.subject,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: 40.r,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          "Levels",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30.sp,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                levelItemBuilder(
                  context,
                  "assets/images/level1.png",
                  "Level 1",
                ),
                levelItemBuilder(
                  context,
                  "assets/images/level2.png",
                  "Level 2",
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                levelItemBuilder(
                  context,
                  "assets/images/level3.png",
                  "Level 3",
                ),
                levelItemBuilder(
                  context,
                  "assets/images/level4.png",
                  "Level 4",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget levelItemBuilder(BuildContext context, String url, String level) {
    return InkWell(
      onTap: () {
        if (screen == 'subjects') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllLessonsScreen(
                subject: subject,
                level: level.split(" ").last,
              ),
            ),
          );
        }else if(screen == 'quizzes'){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllQuizzesScreen(
                subject: subject,
                level: level.split(" ").last,
              ),
            ),
          );
        }else if(screen == 'grades'){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllGradesScreen(
                subject: subject,
                level: level.split(" ").last,
              ),
            ),
          );
        }
      },
      child: Container(
        width: 150.w,
        height: 150.h,
        padding: EdgeInsets.all(15.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.textFormFieldBorder,
            width: 2.5.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(url),
            ),
            Text(
              level,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
