import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/add_lesson/manager/add_lesson_cubit.dart';
import 'package:sen/features/add_lesson/manager/add_lesson_state.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({super.key});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final cubit = AddLessonCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.titleController.dispose();
    cubit.descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AddLessonCubit, AddLessonState>(
        listener: (context, state) {
          if (state is UploadLessonSuccess) {
            onLessonUploadSuccess();
          } else if (state is UploadLessonFailure) {
            displayToast(state.errorMessage);
          } else if (state is UploadVideoFailure) {
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
              "Add Lesson",
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
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Level",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
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
                            "Level 1",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "2",
                          label: Text(
                            "Level 2",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "3",
                          label: Text(
                            "Level 3",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: "4",
                          label: Text(
                            "Level 4",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
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
                "Title",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
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
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
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
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
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
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
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
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<AddLessonCubit, AddLessonState>(
                      buildWhen: (previous, current) =>
                          current is PickVideoSuccess,
                      builder: (context, state) {
                        return Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cubit.pickVideo();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cubit.videoFile == null
                                  ? AppColors.secondary
                                  : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            label: Text(
                              'ATTACH',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: AppFonts.mainFont,
                              ),
                            ),
                            icon: Icon(
                              Icons.attach_file_rounded,
                              color: Colors.white,
                              size: 25.r,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 15.w),
                    BlocBuilder<AddLessonCubit, AddLessonState>(
                      buildWhen: (previous, current) =>
                          current is LoadingChange,
                      builder: (context, state) {
                        return Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cubit.uploadLesson();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            label: Text(
                              'UPLOAD',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: AppFonts.mainFont,
                              ),
                            ),
                            icon: cubit.loading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.upload_rounded,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLessonUploadSuccess() {
    displayToast('Lesson Uploaded');
    Navigator.pop(context);
  }
}
