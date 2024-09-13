import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/quiz_attempt/manager/quiz_attempt_cubit.dart';
import 'package:sen/features/quiz_attempt/manager/quiz_attempt_state.dart';
import 'package:sen/models/quiz.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class QuizAttemptScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizAttemptScreen({super.key, required this.quiz});

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  final cubit = QuizAttemptCubit();

  @override
  void initState() {
    super.initState();
    cubit.answers = List.filled(widget.quiz.questions.length, -1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<QuizAttemptCubit, QuizAttemptState>(
        listener: (context, state) {
          if (state is SubmitQuizSuccess) {
            onSubmitSuccess();
          } else if (state is SubmitQuizFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
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
              widget.quiz.title,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.only(
              top: 15.h,
              bottom: 30.h,
              right: 15.w,
              left: 15.w,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(
                  bottom: 15.h,
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
                      widget.quiz.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Text(
                      widget.quiz.description,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.textGrey,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ],
                ),
              ),
              questionItemBuilder(),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.submit(widget.quiz);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionItemBuilder() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.quiz.questions.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.r),
          margin: EdgeInsets.only(
            bottom: 15.h,
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
                child: widget.quiz.questions[index].url.isEmpty
                    ? const SizedBox()
                    : Image.network(
                        widget.quiz.questions[index].url,
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
                widget.quiz.questions[index].question,
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
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is SelectChange,
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      cubit.answers[index] = 0;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onSelectChange();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.r),
                      margin: EdgeInsets.only(bottom: 15.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cubit.answers[index] == 0
                            ? AppColors.primaryBackground
                            : AppColors.textFormFieldFill,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: cubit.answers[index] == 0
                              ? AppColors.primary
                              : AppColors.textFormFieldBorder,
                          width: 2.5.w,
                        ),
                      ),
                      child: Text(
                        widget.quiz.questions[index].choices[0],
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is SelectChange,
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      cubit.answers[index] = 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onSelectChange();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.r),
                      margin: EdgeInsets.only(bottom: 15.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cubit.answers[index] == 1
                            ? AppColors.primaryBackground
                            : AppColors.textFormFieldFill,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: cubit.answers[index] == 1
                              ? AppColors.primary
                              : AppColors.textFormFieldBorder,
                          width: 2.5.w,
                        ),
                      ),
                      child: Text(
                        widget.quiz.questions[index].choices[1],
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is SelectChange,
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      cubit.answers[index] = 2;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onSelectChange();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.r),
                      margin: EdgeInsets.only(bottom: 15.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cubit.answers[index] == 2
                            ? AppColors.primaryBackground
                            : AppColors.textFormFieldFill,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: cubit.answers[index] == 2
                              ? AppColors.primary
                              : AppColors.textFormFieldBorder,
                          width: 2.5.w,
                        ),
                      ),
                      child: Text(
                        widget.quiz.questions[index].choices[2],
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is SelectChange,
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      cubit.answers[index] = 3;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onSelectChange();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.r),
                      margin: EdgeInsets.only(bottom: 15.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cubit.answers[index] == 3
                            ? AppColors.primaryBackground
                            : AppColors.textFormFieldFill,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: cubit.answers[index] == 3
                              ? AppColors.primary
                              : AppColors.textFormFieldBorder,
                          width: 2.5.w,
                        ),
                      ),
                      child: Text(
                        widget.quiz.questions[index].choices[3],
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onSubmitSuccess() {
    displayToast('Quiz submitted');
    Navigator.pop(context);
  }
}
