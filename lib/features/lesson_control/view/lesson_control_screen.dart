import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/cards_lesson_read/view/cards_lesson_read_screen.dart';
import 'package:sen/features/edit_lesson/view/edit_lesson_screen.dart';
import 'package:sen/features/lesson_control/manager/lesson_control_cubit.dart';
import 'package:sen/features/lesson_control/manager/lesson_control_state.dart';
import 'package:sen/features/lesson_type/view/lesson_type_screen.dart';
import 'package:sen/features/video_lesson_read/view/Video_lesson_read_screen.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class LessonControlScreen extends StatefulWidget {
  const LessonControlScreen({super.key});

  @override
  State<LessonControlScreen> createState() => _LessonControlScreenState();
}

class _LessonControlScreenState extends State<LessonControlScreen> {
  final cubit = LessonControlCubit();

  @override
  void initState() {
    super.initState();
    cubit.getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LessonTypeScreen(),
                  ),
                ).then((_) {
                  cubit.getLessons();
                });
              },
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.add_box_rounded,
                size: 35.r,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  cubit.searchLessons(value);
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
                  label: BlocBuilder<AppManagerCubit, AppManagerState>(
                    buildWhen: (previous, current) => current is LanguageChange,
                    builder: (context, state) {
                      return Text(
                        S().search,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppFonts.mainFont,
                        ),
                      );
                    },
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              lessonItemBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget lessonItemBuilder() {
    return BlocBuilder<LessonControlCubit, LessonControlState>(
      buildWhen: (previous, current) =>
          current is GetLessonsSuccess || current is DeleteLessonsSuccess,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
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
                    bottom: 15.h,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is LanguageChange,
                        builder: (context, state) {
                          return Text(
                            "${S().title} : ${cubit.lessons[index].title}",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          );
                        },
                      ),
                      Text(
                        cubit.lessons[index].description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is LanguageChange,
                        builder: (context, state) {
                          return Text(
                            "${S().level} : ${cubit.lessons[index].level}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditLessonScreen(
                                      lesson: cubit.lessons[index],
                                    ),
                                  ),
                                ).then((_) {
                                  cubit.getLessons();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              label:
                                  BlocBuilder<AppManagerCubit, AppManagerState>(
                                buildWhen: (previous, current) =>
                                    current is LanguageChange,
                                builder: (context, state) {
                                  return Text(
                                    S().edit,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFonts.mainFont,
                                    ),
                                  );
                                },
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 25.r,
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showAlertDialog(index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              label:
                                  BlocBuilder<AppManagerCubit, AppManagerState>(
                                buildWhen: (previous, current) =>
                                    current is LanguageChange,
                                builder: (context, state) {
                                  return Text(
                                    S().delete,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFonts.mainFont,
                                    ),
                                  );
                                },
                              ),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 25.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showAlertDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            S().confirmDeletion,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          content: Text(
            S().areYouSureLesson,
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.textGrey
                  : Colors.white,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      S().cancel,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.deleteLesson(index);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      S().delete,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
