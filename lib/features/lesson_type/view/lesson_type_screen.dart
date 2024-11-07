import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/add_cards_lesson/view/add_cards_lesson_screen.dart';
import 'package:sen/features/add_video_lesson/view/add_video_lesson_screen.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class LessonTypeScreen extends StatelessWidget {
  const LessonTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.r,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          S().lessonType,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
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
            lessonTypeItemBuilder(
                context, "assets/animations/cards.json", S().cards),
            lessonTypeItemBuilder(
                context, "assets/animations/videos.json", S().video),
          ],
        ),
      ),
    );
  }

  Widget lessonTypeItemBuilder(BuildContext context, String url, String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (title == "Cards") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCardsLessonScreen(),
              ),
            );
          } else if (title == "Video") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddVideoLessonScreen(),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(15.r),
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 15.h),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : AppColors.textFormFieldFillDark,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.textFormFieldBorder,
              width: 2.5.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Lottie.asset(url)),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
