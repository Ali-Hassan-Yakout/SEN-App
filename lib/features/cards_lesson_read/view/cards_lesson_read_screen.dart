import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/models/lesson.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class CardsLessonReadScreen extends StatefulWidget {
  final Lesson lesson;

  const CardsLessonReadScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<CardsLessonReadScreen> createState() => _CardsLessonReadScreenState();
}

class _CardsLessonReadScreenState extends State<CardsLessonReadScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (currentIndex == 0) {
              Navigator.pop(context);
            } else {
              currentIndex -= 1;
              BlocProvider.of<AppManagerCubit>(context).onScreenChange();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.r,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          widget.lesson.title,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: BlocBuilder<AppManagerCubit, AppManagerState>(
        buildWhen: (previous, current) => current is ScreenChange,
        builder: (context, state) {
          return Visibility(
            visible: currentIndex < widget.lesson.cards.length,
            child: FloatingActionButton(
              onPressed: () {
                if (currentIndex < widget.lesson.cards.length) {
                  currentIndex++;
                  BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                }
              },
              backgroundColor: AppColors.secondary,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 25.r,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) => current is ScreenChange,
          builder: (context, state) {
            return currentIndex == widget.lesson.cards.length
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S().thisIsAllForThisLesson,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                        width: 300.w,
                        height: 55.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            S().goToLessons,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                      ),
                      Lottie.asset(
                        "assets/animations/bye.json",
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  )
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: LinearProgressIndicator(
                          color: AppColors.secondary,
                          backgroundColor: AppColors.textFormFieldBorder,
                          minHeight: 15.h,
                          borderRadius: BorderRadius.circular(16.r),
                          value: currentIndex.toDouble() +
                              1 / widget.lesson.cards.length,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Image.network(
                            widget.lesson.cards[currentIndex].url),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        widget.lesson.cards[currentIndex].content,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
