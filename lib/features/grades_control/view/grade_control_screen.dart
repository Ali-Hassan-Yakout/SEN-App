import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/grades_control/manager/grades_control_cubit.dart';
import 'package:sen/features/grades_control/manager/grades_control_state.dart';
import 'package:sen/features/student_quizzes/view/student_quizzes_screen.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class GradeControlScreen extends StatefulWidget {
  const GradeControlScreen({super.key});

  @override
  State<GradeControlScreen> createState() => _GradeControlScreenState();
}

class _GradeControlScreenState extends State<GradeControlScreen> {
  final cubit = GradesControlCubit();

  @override
  void initState() {
    super.initState();
    cubit.getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<GradesControlCubit, GradesControlState>(
        listener: (context, state) {
          if (state is GetStudentsFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    cubit.searchStudents(value);
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
                      buildWhen: (previous, current) =>
                          current is LanguageChange,
                      builder: (context, state) {
                        return Text(
                          S().search,
                          style: TextStyle(
                            fontSize: 18.sp,
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
                Expanded(
                  child: BlocBuilder<GradesControlCubit, GradesControlState>(
                    buildWhen: (previous, current) =>
                        current is GetStudentsSuccess,
                    builder: (context, state) {
                      return allStudentsItemBuilder();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allStudentsItemBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cubit.students.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentQuizzesScreen(
                  studentId: cubit.students[index].userId,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15.r),
            margin: EdgeInsets.only(bottom: 15.w),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      backgroundColor: AppColors.primaryBackground,
                      child: cubit.students[index].avatar.isEmpty
                          ? Text(
                              cubit.students[index].name[0],
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontFamily: AppFonts.mainFont,
                              ),
                            )
                          : Image.asset(cubit.students[index].avatar),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.students[index].name,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          Text(
                            cubit.students[index].email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.textGrey
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          Row(
                            children: [
                              BlocBuilder<AppManagerCubit, AppManagerState>(
                                buildWhen: (previous, current) =>
                                    current is LanguageChange,
                                builder: (context, state) {
                                  return Text(
                                    "${S().grade} : ${cubit.students[index].grade}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? AppColors.textGrey
                                          : Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFonts.mainFont,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 15.w),
                              BlocBuilder<AppManagerCubit, AppManagerState>(
                                buildWhen: (previous, current) =>
                                    current is LanguageChange,
                                builder: (context, state) {
                                  return Text(
                                    "${S().age} : ${cubit.students[index].age}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? AppColors.textGrey
                                          : Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFonts.mainFont,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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
  }
}
