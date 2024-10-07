import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_quizzes/manager/all_quizzes_cubit.dart';
import 'package:sen/features/all_quizzes/manager/all_quizzes_state.dart';
import 'package:sen/features/quiz_attempt/view/quiz_attempt_screen.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class AllQuizzesScreen extends StatefulWidget {
  final String subject;
  final String level;

  const AllQuizzesScreen({
    super.key,
    required this.subject,
    required this.level,
  });

  @override
  State<AllQuizzesScreen> createState() => _AllQuizzesScreenState();
}

class _AllQuizzesScreenState extends State<AllQuizzesScreen> {
  final cubit = AllQuizzesCubit();

  @override
  void initState() {
    super.initState();
    cubit.getQuizzes(widget.level, widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AllQuizzesCubit, AllQuizzesState>(
        listener: (context, state) {
          if (state is GetQuizzesFailure) {
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
                Icons.arrow_back_ios_new_rounded,
                size: 25.r,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              S().quizzes,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: allQuizzesItemBuilder(),
        ),
      ),
    );
  }

  Widget allQuizzesItemBuilder() {
    return BlocBuilder<AllQuizzesCubit, AllQuizzesState>(
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
                    builder: (context) => QuizAttemptScreen(
                      quiz: cubit.quizzes[index],
                    ),
                  ),
                ).then((value) {
                  cubit.getQuizzes(widget.level, widget.subject);
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
                      "${S().mr} : ${cubit.quizzes[index].teacherName}",
                      style: TextStyle(
                        fontSize: 18.sp,
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
                        color: AppColors.textGrey,
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
