import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sen/models/attempt.dart';
import 'package:sen/models/quiz.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class AttemptReadScreen extends StatelessWidget {
  final Quiz quiz;
  final Attempt attempt;

  const AttemptReadScreen({
    super.key,
    required this.quiz,
    required this.attempt,
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
          "Answers",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30.sp,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.r),
            margin: EdgeInsets.only(
              top: 15.h,
              right: 15.w,
              left: 15.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.textFormFieldBorder,
                width: 2.5.w,
              ),
            ),
            child: Column(
              children: [
                Text(
                  quiz.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                Text(
                  quiz.description,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.r),
            margin: EdgeInsets.only(
              top: 15.h,
              right: 15.w,
              left: 15.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.textFormFieldBorder,
                width: 2.5.w,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Grade',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 15.h),
                CircularPercentIndicator(
                  radius: 60.r,
                  lineWidth: 10.w,
                  percent: attempt.score / attempt.answers.length,
                  center: Text(
                    "${(attempt.score / quiz.questions.length) * 100}%",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.textGrey,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  progressColor: Colors.green,
                )
              ],
            ),
          ),
          questionItemBuilder(),
        ],
      ),
    );
  }

  Widget questionItemBuilder() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quiz.questions.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.r),
          margin: EdgeInsets.only(
            top: 15.h,
            right: 15.w,
            left: 15.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.textFormFieldBorder,
              width: 2.5.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: quiz.questions[index].url.isEmpty
                    ? const SizedBox()
                    : Image.network(
                        quiz.questions[index].url,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              Text(
                'Question :',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                quiz.questions[index].question,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Answers :',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(bottom: 15.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textFormFieldFill,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: quiz.questions[index].correctAnswer == 0
                        ? Colors.green
                        : attempt.answers[index] == 0
                            ? Colors.red
                            : AppColors.textFormFieldBorder,
                    width: 2.5.w,
                  ),
                ),
                child: Text(
                  quiz.questions[index].choices[0],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(bottom: 15.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textFormFieldFill,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: quiz.questions[index].correctAnswer == 1
                        ? Colors.green
                        : attempt.answers[index] == 1
                            ? Colors.red
                            : AppColors.textFormFieldBorder,
                    width: 2.5.w,
                  ),
                ),
                child: Text(
                  quiz.questions[index].choices[1],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(bottom: 15.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textFormFieldFill,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: quiz.questions[index].correctAnswer == 2
                        ? Colors.green
                        : attempt.answers[index] == 2
                            ? Colors.red
                            : AppColors.textFormFieldBorder,
                    width: 2.5.w,
                  ),
                ),
                child: Text(
                  quiz.questions[index].choices[2],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(bottom: 15.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textFormFieldFill,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: quiz.questions[index].correctAnswer == 3
                        ? Colors.green
                        : attempt.answers[index] == 3
                            ? Colors.red
                            : AppColors.textFormFieldBorder,
                    width: 2.5.w,
                  ),
                ),
                child: Text(
                  quiz.questions[index].choices[3],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
