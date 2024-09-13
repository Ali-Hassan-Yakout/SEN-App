import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_grades/manager/all_grades_cubit.dart';
import 'package:sen/features/all_grades/manager/all_grades_state.dart';
import 'package:sen/features/attempt_read/view/attempt_read_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class AllGradesScreen extends StatefulWidget {
  final String subject;
  final String level;

  const AllGradesScreen({
    super.key,
    required this.subject,
    required this.level,
  });

  @override
  State<AllGradesScreen> createState() => _AllGradesScreenState();
}

class _AllGradesScreenState extends State<AllGradesScreen> {
  final cubit = AllGradesCubit();

  @override
  void initState() {
    super.initState();
    cubit.getQuizzes(widget.level, widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AllGradesCubit, AllGradesState>(
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
                Icons.arrow_circle_left_rounded,
                size: 40.r,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              "Grades",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: allGradesItemBuilder(),
        ),
      ),
    );
  }

  Widget allGradesItemBuilder() {
    return BlocBuilder<AllGradesCubit, AllGradesState>(
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
                );
              },
              child: Container(
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(
                  top: 15.h,
                  left: 15.w,
                  right: 15.w,
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
                  children: [
                    Text(
                      "Title : ${cubit.quizzes[index].title}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Text(
                      "MR : ${cubit.quizzes[index].teacherName}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
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
