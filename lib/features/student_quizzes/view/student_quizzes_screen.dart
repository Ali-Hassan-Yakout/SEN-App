import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/attempt_read/view/attempt_read_screen.dart';
import 'package:sen/features/student_quizzes/manager/student_quizzes_cubit.dart';
import 'package:sen/features/student_quizzes/manager/student_quizzes_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class StudentQuizzesScreen extends StatefulWidget {
  final String studentId;

  const StudentQuizzesScreen({
    super.key,
    required this.studentId,
  });

  @override
  State<StudentQuizzesScreen> createState() => _StudentQuizzesScreenState();
}

class _StudentQuizzesScreenState extends State<StudentQuizzesScreen> {
  final cubit = StudentQuizzesCubit();

  @override
  void initState() {
    super.initState();
    cubit.getQuizzes(widget.studentId);
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
            "Quizzes",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 30.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          centerTitle: true,
        ),
        body: studentQuizzesItemBuilder(),
      ),
    );
  }

  Widget studentQuizzesItemBuilder() {
    return BlocBuilder<StudentQuizzesCubit, StudentQuizzesState>(
      buildWhen: (previous, current) => current is GetQuizzesSuccess,
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.quizzes.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttemptReadScreen(
                      quiz: cubit.quizzes[index],
                      attempt: cubit.attempts[index],
                    ),
                  ),
                ).then((value) {
                  cubit.getQuizzes(widget.studentId);
                });
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
                      "${S().title} : ${cubit.quizzes[index].title}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Text(
                      cubit.quizzes[index].description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.textGrey
                            : Colors.white,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${S().level} : ${cubit.quizzes[index].level}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        Text(
                          "${S().quizGrade} ${(cubit.attempts[index].score / cubit.attempts[index].answers.length) * 100}%",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.textGrey
                                    : Colors.white,
                            fontFamily: AppFonts.mainFont,
                          ),
                        ),
                      ],
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
