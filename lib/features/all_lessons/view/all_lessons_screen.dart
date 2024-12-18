import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_lessons/manager/all_lessons_cubit.dart';
import 'package:sen/features/all_lessons/manager/all_lessons_state.dart';
import 'package:sen/features/cards_lesson_read/view/cards_lesson_read_screen.dart';
import 'package:sen/features/video_lesson_read/view/video_lesson_read_screen.dart';

import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class AllLessonsScreen extends StatefulWidget {
  final String level;
  final String subject;

  const AllLessonsScreen({
    super.key,
    required this.level,
    required this.subject,
  });

  @override
  State<AllLessonsScreen> createState() => _AllLessonsScreenState();
}

class _AllLessonsScreenState extends State<AllLessonsScreen> {
  final cubit = AllLessonsCubit();

  @override
  void initState() {
    super.initState();
    cubit.getLessons(widget.level, widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
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
            S().lessons,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 30.sp,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          centerTitle: true,
        ),
        body: allLessonItemBuilder(),
      ),
    );
  }

  Widget allLessonItemBuilder() {
    return BlocBuilder<AllLessonsCubit, AllLessonsState>(
      buildWhen: (previous, current) => current is GetLessonsSuccess,
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.lessons.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (cubit.lessons[index].url.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardsLessonReadScreen(
                        lesson: cubit.lessons[index],
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoLessonReadScreen(
                        lesson: cubit.lessons[index],
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(
                  top: 15.h,
                  left: 15.w,
                  right: 15.w,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.textFormFieldFillDark,
                  border: Border.all(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5.w,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${S().title} : ${cubit.lessons[index].title}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Text(
                      "${S().mr} : ${cubit.lessons[index].teacherName}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Text(
                      cubit.lessons[index].description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
