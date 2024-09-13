import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/add_quiz/Manager/add_quiz_cubit.dart';
import 'package:sen/features/add_quiz/Manager/add_quiz_state.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final cubit = AddQuizCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AddQuizCubit, AddQuizState>(
        listener: (context, state) {
          if (state is UploadQuizSuccess) {
            onQuizUploadSuccess();
          } else if (state is UploadQuizFailure) {
            displayToast(state.errorMessage);
          } else if (state is UploadImageFailure) {
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
              "Add Quiz",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
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
                  textInputAction: TextInputAction.done,
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
                TextFormField(
                  controller: cubit.descriptionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColors.primary,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
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
                SizedBox(height: 15.h),
                questionItemBuilder(),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            cubit.onAddQuestion();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          label: Text(
                            'QUESTION',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25.r,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      BlocBuilder<AddQuizCubit, AddQuizState>(
                        buildWhen: (previous, current) =>
                            current is LoadingChange,
                        builder: (context, state) {
                          return Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                cubit.uploadQuiz();
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
      ),
    );
  }

  Widget questionItemBuilder() {
    return BlocBuilder<AddQuizCubit, AddQuizState>(
      buildWhen: (previous, current) =>
          current is AddQuestionSuccess || current is RemoveQuestionSuccess,
      builder: (context, state) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cubit.questions.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.r),
              margin: EdgeInsets.only(bottom: 15.h),
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
                    child: BlocBuilder<AddQuizCubit, AddQuizState>(
                      buildWhen: (previous, current) =>
                          current is PickImageSuccess,
                      builder: (context, state) {
                        return cubit.questions[index].image == null
                            ? const SizedBox()
                            : Image.file(
                                cubit.questions[index].image!,
                                fit: BoxFit.fitWidth,
                              );
                      },
                    ),
                  ),
                  Text(
                    'Question :',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    onChanged: (value) {
                      cubit.questions[index].question = value;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
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
                    'Answers :',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is SelectChange,
                        builder: (context, state) {
                          return RadioMenuButton(
                            value: 0,
                            groupValue: cubit.questions[index].correctAnswer,
                            onChanged: (value) {
                              cubit.questions[index].correctAnswer = value!;
                              BlocProvider.of<AppManagerCubit>(context)
                                  .onSelectChange();
                            },
                            child: const Text(''),
                          );
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.questions[index].choices[0] = value;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is SelectChange,
                        builder: (context, state) {
                          return RadioMenuButton(
                            value: 1,
                            groupValue: cubit.questions[index].correctAnswer,
                            onChanged: (value) {
                              cubit.questions[index].correctAnswer = value!;
                              BlocProvider.of<AppManagerCubit>(context)
                                  .onSelectChange();
                            },
                            child: const Text(''),
                          );
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.questions[index].choices[1] = value;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is SelectChange,
                        builder: (context, state) {
                          return RadioMenuButton(
                            value: 2,
                            groupValue: cubit.questions[index].correctAnswer,
                            onChanged: (value) {
                              cubit.questions[index].correctAnswer = value!;
                              BlocProvider.of<AppManagerCubit>(context)
                                  .onSelectChange();
                            },
                            child: const Text(''),
                          );
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.questions[index].choices[2] = value;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<AppManagerCubit, AppManagerState>(
                        buildWhen: (previous, current) =>
                            current is SelectChange,
                        builder: (context, state) {
                          return RadioMenuButton(
                            value: 3,
                            groupValue: cubit.questions[index].correctAnswer,
                            onChanged: (value) {
                              cubit.questions[index].correctAnswer = value!;
                              BlocProvider.of<AppManagerCubit>(context)
                                  .onSelectChange();
                            },
                            child: const Text(''),
                          );
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.questions[index].choices[3] = value;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cubit.pickImage(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
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
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cubit.deleteQuestion(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            label: Text(
                              'Delete',
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
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onQuizUploadSuccess() {
    displayToast('Quiz Uploaded');
    Navigator.pop(context);
  }
}
