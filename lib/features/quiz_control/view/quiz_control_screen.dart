import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/add_quiz/view/add_quiz_screen.dart';
import 'package:sen/features/quiz_answer/view/quiz_answer_screen.dart';
import 'package:sen/features/quiz_control/manager/quiz_control_cubit.dart';
import 'package:sen/features/quiz_control/manager/quiz_control_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class QuizControlScreen extends StatefulWidget {
  const QuizControlScreen({super.key});

  @override
  State<QuizControlScreen> createState() => _QuizControlScreenState();
}

class _QuizControlScreenState extends State<QuizControlScreen> {
  final cubit = QuizControlCubit();

  @override
  void initState() {
    super.initState();
    cubit.getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<QuizControlCubit, QuizControlState>(
        listener: (context, state) {
          if (state is DeleteQuizzesFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddQuizScreen(),
                    ),
                  ).then((value) {
                    cubit.getQuizzes();
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
                    cubit.searchQuizzes(value);
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColors.primary,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.textGrey,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.textFormFieldFill,
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
                quizItemBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quizItemBuilder() {
    return BlocBuilder<QuizControlCubit, QuizControlState>(
      buildWhen: (previous, current) =>
          current is GetQuizzesSuccess || current is DeleteQuizzesSuccess,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.quizzes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizAnswerScreen(
                        quiz: cubit.quizzes[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15.r),
                  margin: EdgeInsets.only(
                    bottom: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Title : ${cubit.quizzes[index].title}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: AppFonts.mainFont,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                showAlertDialog(index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        cubit.quizzes[index].description,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                      Text(
                        "Level : ${cubit.quizzes[index].level}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textGrey,
                          fontFamily: AppFonts.mainFont,
                        ),
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
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(
              fontFamily: AppFonts.mainFont,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this quiz?',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textGrey,
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
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.deleteQuiz(index);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
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
