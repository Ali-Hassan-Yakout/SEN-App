import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/edit_lesson/manager/edit_lesson_cubit.dart';
import 'package:sen/features/edit_lesson/manager/edit_lesson_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/models/lesson.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class EditLessonScreen extends StatefulWidget {
  final Lesson lesson;

  const EditLessonScreen({super.key, required this.lesson});

  @override
  State<EditLessonScreen> createState() => _EditLessonScreenState();
}

class _EditLessonScreenState extends State<EditLessonScreen> {
  final cubit = EditLessonCubit();

  @override
  void initState() {
    super.initState();
    cubit.titleController.text = widget.lesson.title;
    cubit.descriptionController.text = widget.lesson.description;
    cubit.level.add(widget.lesson.level);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.descriptionController.dispose();
    cubit.titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<EditLessonCubit, EditLessonState>(
        listener: (context, state) {
          if (state is EditLessonSuccess) {
            onEditLessonSuccess();
          } else if (state is EditLessonFailure) {
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
              S().editLesson,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30.sp,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  S().level,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<AppManagerCubit, AppManagerState>(
                  buildWhen: (previous, current) => current is SelectChange,
                  builder: (context, state) {
                    return SegmentedButton(
                      emptySelectionAllowed: true,
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: "1",
                          label: Text(
                            "${S().level} 1",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "2",
                          label: Text(
                            "${S().level} 2",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "3",
                          label: Text(
                            "${S().level} 3",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "4",
                          label: Text(
                            "${S().level} 4",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                      ],
                      selected: cubit.level,
                      onSelectionChanged: (value) {
                        cubit.level = value;
                        BlocProvider.of<AppManagerCubit>(context)
                            .onSelectChange();
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                S().title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              TextFormField(
                controller: cubit.titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
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
              Text(
                S().description,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 360.h,
                child: TextFormField(
                  controller: cubit.descriptionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColors.primary,
                  style: const TextStyle(
                    fontFamily: AppFonts.mainFont,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
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
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    cubit.editLesson(widget.lesson.lessonId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  label: Text(
                    S().edit,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 25.r,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onEditLessonSuccess() {
    displayToast('Lesson Edited');
    Navigator.pop(context);
  }
}
