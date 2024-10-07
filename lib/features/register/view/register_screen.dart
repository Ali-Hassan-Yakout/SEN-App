import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/parent_home/view/parent_home_screen.dart';
import 'package:sen/features/register/manager/register_cubit.dart';
import 'package:sen/features/register/manager/register_state.dart';
import 'package:sen/features/teacher_home/view/teacher_home_screen.dart';
import 'package:sen/features/therapist_home/view/therapist_home_screen.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final cubit = RegisterCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.parentEmailController.dispose();
    cubit.parentPasswordController.dispose();
    cubit.parentAgeController.dispose();
    cubit.childAgeController.dispose();
    cubit.childNameController.dispose();
    cubit.childGradeController.dispose();
    cubit.teacherEmailController.dispose();
    cubit.teacherNameController.dispose();
    cubit.teacherPasswordController.dispose();
    cubit.therapistEmailController.dispose();
    cubit.therapistNameController.dispose();
    cubit.therapistPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            onRegisterSuccess();
          } else if (state is RegisterFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (cubit.progress > 1) {
                  cubit.progress -= 1;
                  BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                } else if (cubit.progress == 1 && cubit.userType == "") {
                  Navigator.pop(context);
                } else if (cubit.progress == 1) {
                  cubit.numberOfPages = 2;
                  cubit.userType = "";
                  BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25.r,
                color: AppColors.primary,
              ),
            ),
            title: BlocBuilder<AppManagerCubit, AppManagerState>(
              buildWhen: (previous, current) => current is ScreenChange,
              builder: (context, state) {
                return LinearProgressIndicator(
                  color: AppColors.secondary,
                  backgroundColor: AppColors.textFormFieldBorder,
                  minHeight: 15.h,
                  borderRadius: BorderRadius.circular(16.r),
                  value: cubit.progress / cubit.numberOfPages,
                );
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            child: BlocBuilder<AppManagerCubit, AppManagerState>(
              buildWhen: (previous, current) => current is ScreenChange,
              builder: (context, state) {
                return userForm();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget userForm() {
    if (cubit.userType == 'parent') {
      return parentForm();
    } else if (cubit.userType == 'teacher') {
      return teacherForm();
    } else if (cubit.userType == 'therapist') {
      return therapistForm();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S().whoAreYou,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            S().pleaseChooseYourRole,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.numberOfPages = 10;
                    cubit.userType = "parent";
                    BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.textFormFieldFillLight
                          : AppColors.textFormFieldFillDark,
                      border: Border.all(
                        color: AppColors.textFormFieldBorder,
                        width: 2.5.w,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/parents.png",
                          fit: BoxFit.contain,
                        ),
                        Text(
                          S().parent,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.mainFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.userType = "teacher";
                    BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.textFormFieldFillLight
                          : AppColors.textFormFieldFillDark,
                      border: Border.all(
                        color: AppColors.textFormFieldBorder,
                        width: 2.5.w,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/teacher.png",
                          fit: BoxFit.contain,
                        ),
                        Text(
                          S().teacher,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.mainFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.userType = "therapist";
                    BlocProvider.of<AppManagerCubit>(context).onScreenChange();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.textFormFieldFillLight
                          : AppColors.textFormFieldFillDark,
                      border: Border.all(
                        color: AppColors.textFormFieldBorder,
                        width: 2.5.w,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/therapist.png",
                          fit: BoxFit.contain,
                        ),
                        Text(
                          S().therapist,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.mainFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget parentForm() {
    if (cubit.progress == 1) {
      return BlocBuilder<AppManagerCubit, AppManagerState>(
        buildWhen: (previous, current) => current is SelectChange,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S().howDidYouHearAboutSEN,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {
                  cubit.media = "Facebook/Instgram";
                  cubit.mediaIndex = 1;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.mediaIndex == 1
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r),
                    ),
                    border: Border.all(
                      color: cubit.mediaIndex == 1
                          ? AppColors.primary
                          : AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  child: Text(
                    S().facebookInstagram,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.media = "YouTube";
                  cubit.mediaIndex = 2;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.mediaIndex == 2
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    border: cubit.mediaIndex == 2
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2.5.w,
                          )
                        : Border(
                            right: BorderSide(
                              color: cubit.mediaIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            left: BorderSide(
                              color: cubit.mediaIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            bottom: BorderSide(
                              color: cubit.mediaIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                          ),
                  ),
                  child: Text(
                    S().youTube,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.media = "Teacher/school";
                  cubit.mediaIndex = 3;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.mediaIndex == 3
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    border: cubit.mediaIndex == 3
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2.5.w,
                          )
                        : Border(
                            right: BorderSide(
                              color: cubit.mediaIndex == 3
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            left: BorderSide(
                              color: cubit.mediaIndex == 3
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            bottom: BorderSide(
                              color: cubit.mediaIndex == 3
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                          ),
                  ),
                  child: Text(
                    S().teacherSchool,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.media = "Friends/family";
                  cubit.mediaIndex = 4;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.mediaIndex == 4
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    border: cubit.mediaIndex == 4
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2.5.w,
                          )
                        : Border(
                            right: BorderSide(
                              color: cubit.mediaIndex == 4
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            left: BorderSide(
                              color: cubit.mediaIndex == 4
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            bottom: BorderSide(
                              color: cubit.mediaIndex == 4
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                          ),
                  ),
                  child: Text(
                    S().friendsFamily,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.media = "Other";
                  cubit.mediaIndex = 5;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.mediaIndex == 5
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    border: cubit.mediaIndex == 5
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2.5.w,
                          )
                        : Border(
                            right: BorderSide(
                              color: cubit.mediaIndex == 5
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            left: BorderSide(
                              color: cubit.mediaIndex == 5
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            bottom: BorderSide(
                              color: cubit.mediaIndex == 5
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                          ),
                  ),
                  child: Text(
                    S().other,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.mediaIndex != 0) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.mediaIndex == 0
                        ? Colors.grey[400]
                        : AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.mediaIndex == 0
                          ? AppColors.textGrey
                          : Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else if (cubit.progress == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S().createAnAccountToTrack,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          TextFormField(
            controller: cubit.parentEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            cursorColor: AppColors.primary,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
            onChanged: (value) {
              if (value.contains(".com") && value.contains("@")) {
                cubit.validEmail = true;
              } else {
                cubit.validEmail = false;
              }
              BlocProvider.of<AppManagerCubit>(context).onTextFormFieldChange();
            },
            decoration: InputDecoration(
              hintText: S().emailAddress,
              hintStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
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
                  width: 3.w,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
                borderSide: BorderSide(
                  color: AppColors.textFormFieldBorder,
                  width: 3.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.validEmail) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        cubit.validEmail ? AppColors.primary : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color:
                          cubit.validEmail ? Colors.white : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S().bySigning,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.textGrey
                        : Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: S().terms,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 17.sp,
                    fontFamily: AppFonts.mainFont,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: S().and,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.textGrey
                        : Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: S().privacyPolicy,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 17.sp,
                    fontFamily: AppFonts.mainFont,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (cubit.progress == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animations/enter_password.json",
            width: 250.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            S().createAPassword,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ObscureChange,
            builder: (context, state) {
              return TextFormField(
                controller: cubit.parentPasswordController,
                obscureText: cubit.parentObscure,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                onChanged: (value) {
                  BlocProvider.of<AppManagerCubit>(context)
                      .onTextFormFieldChange();
                },
                decoration: InputDecoration(
                  hintText: S().password,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.parentObscure = !cubit.parentObscure;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onObscureChange();
                    },
                    icon: Icon(
                      cubit.parentObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 35.r,
                      color: AppColors.primary,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.parentPasswordController.text.length > 6) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        cubit.parentPasswordController.text.length > 6
                            ? AppColors.primary
                            : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.parentPasswordController.text.length > 6
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (cubit.progress == 4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animations/grown_up.json",
            width: 250.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            S().areYouAGrownUp,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            S().weWantToKeepKidsSafe,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ObscureChange,
            builder: (context, state) {
              return TextFormField(
                controller: cubit.parentAgeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                onChanged: (value) {
                  BlocProvider.of<AppManagerCubit>(context)
                      .onTextFormFieldChange();
                },
                decoration: InputDecoration(
                  hintText: S().age,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if ((int.tryParse(cubit.parentAgeController.text) ?? 0) >=
                        20) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (int.tryParse(cubit.parentAgeController.text) ?? 0) >=
                                20
                            ? AppColors.primary
                            : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color:
                          (int.tryParse(cubit.parentAgeController.text) ?? 0) >=
                                  20
                              ? Colors.white
                              : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (cubit.progress == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animations/child.json",
            width: 250.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            S().whatIsYourChildName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            S().theyLearnHowToWriteItThemselves,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ObscureChange,
            builder: (context, state) {
              return TextFormField(
                controller: cubit.childNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                onChanged: (value) {
                  BlocProvider.of<AppManagerCubit>(context)
                      .onTextFormFieldChange();
                },
                decoration: InputDecoration(
                  hintText: S().name,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.childNameController.text.length > 2) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.childNameController.text.length > 2
                        ? AppColors.primary
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.childNameController.text.length > 2
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (cubit.progress == 6) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animations/birthday.json",
            width: 250.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            "${S().howOldIs}${cubit.childNameController.text}${S().questionMark}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            S().wePersonalizeTheExperienceForThisAge,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ObscureChange,
            builder: (context, state) {
              return TextFormField(
                controller: cubit.childAgeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                onChanged: (value) {
                  BlocProvider.of<AppManagerCubit>(context)
                      .onTextFormFieldChange();
                },
                decoration: InputDecoration(
                  hintText: S().age,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.childAgeController.text.isNotEmpty) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.childAgeController.text.isNotEmpty
                        ? AppColors.primary
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.childAgeController.text.isNotEmpty
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (cubit.progress == 7) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animations/classroom.json",
            width: 250.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            "${S().inWhichGrade}${cubit.childNameController.text} ${S().questionMark}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            S().wePersonalizeTheExperienceForThisGrade,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is ObscureChange,
            builder: (context, state) {
              return TextFormField(
                controller: cubit.childGradeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                onChanged: (value) {
                  BlocProvider.of<AppManagerCubit>(context)
                      .onTextFormFieldChange();
                },
                decoration: InputDecoration(
                  hintText: S().grade,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFormFieldFillLight
                      : AppColors.textFormFieldFillDark,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is TextFormFieldChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.childGradeController.text.isNotEmpty) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.childGradeController.text.isNotEmpty
                        ? AppColors.primary
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.childGradeController.text.isNotEmpty
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (cubit.progress == 8) {
      return BlocBuilder<AppManagerCubit, AppManagerState>(
        buildWhen: (previous, current) => current is SelectChange,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/learning.json",
                width: 250.w,
                fit: BoxFit.fitWidth,
              ),
              Text(
                "${S().whichDifficultiesFace} ${cubit.childNameController.text} ${S().questionMark}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                S().wePersonalizeTheExperienceForTheseDifficulties,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {
                  cubit.difficulties = "Conduct disorder";
                  cubit.difficultiesIndex = 1;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.difficultiesIndex == 1
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r),
                    ),
                    border: Border.all(
                      color: cubit.difficultiesIndex == 1
                          ? AppColors.primary
                          : AppColors.textFormFieldBorder,
                      width: 2.5.w,
                    ),
                  ),
                  child: Text(
                    S().conductDisorder,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.difficulties = "Learning difficulties";
                  cubit.difficultiesIndex = 2;
                  BlocProvider.of<AppManagerCubit>(context).onSelectChange();
                },
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: cubit.difficultiesIndex == 2
                        ? AppColors.primaryBackground
                        : Theme.of(context).brightness == Brightness.light
                            ? AppColors.textFormFieldFillLight
                            : AppColors.textFormFieldFillDark,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    border: cubit.difficultiesIndex == 2
                        ? Border.all(
                            color: AppColors.primary,
                            width: 2.5.w,
                          )
                        : Border(
                            right: BorderSide(
                              color: cubit.difficultiesIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            left: BorderSide(
                              color: cubit.difficultiesIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                            bottom: BorderSide(
                              color: cubit.difficultiesIndex == 2
                                  ? AppColors.primary
                                  : AppColors.textFormFieldBorder,
                              width: 2.5.w,
                            ),
                          ),
                  ),
                  child: Text(
                    S().learningDifficulties,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.difficultiesIndex != 0) {
                      cubit.progress += 1;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onScreenChange();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.difficultiesIndex != 0
                        ? AppColors.primary
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.difficultiesIndex != 0
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else if (cubit.progress == 9) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${S().chooseAnAvatarFor} ${cubit.childNameController.text}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              avatar("assets/images/cat.png"),
              avatar("assets/images/duck.png"),
              avatar("assets/images/horse.png"),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              avatar("assets/images/lion.png"),
              avatar("assets/images/monkey.png"),
              avatar("assets/images/panda.png"),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              avatar("assets/images/penguin.png"),
              avatar("assets/images/rabbit.png"),
              avatar("assets/images/shark.png"),
            ],
          ),
          const Spacer(),
          BlocBuilder<AppManagerCubit, AppManagerState>(
            buildWhen: (previous, current) => current is SelectChange,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.childAvatar.isNotEmpty) {
                      cubit.parentRegister();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cubit.childAvatar.isNotEmpty
                        ? AppColors.primary
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    S().continueQ,
                    style: TextStyle(
                      color: cubit.childAvatar.isNotEmpty
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget teacherForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S().enterYourDetails,
          style: TextStyle(
            fontSize: 25.sp,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          controller: cubit.teacherEmailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          cursorColor: AppColors.primary,
          style: const TextStyle(
            fontFamily: AppFonts.mainFont,
          ),
          decoration: InputDecoration(
            hintText: S().emailAddress,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18.sp,
              fontFamily: AppFonts.mainFont,
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? AppColors.textFormFieldFillLight
                : AppColors.textFormFieldFillDark,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              borderSide: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 3.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              borderSide: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 3.w,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.textFormFieldFillLight
                : AppColors.textFormFieldFillDark,
            border: const Border(
              right: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
              left: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
              bottom: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
            ),
          ),
          child: TextFormField(
            controller: cubit.teacherNameController,
            keyboardType: TextInputType.name,
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
              hintText: S().name,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18.sp,
                fontFamily: AppFonts.mainFont,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) => current is ObscureChange,
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.textFormFieldFillLight
                    : AppColors.textFormFieldFillDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                border: const Border(
                  right: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                  left: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                  bottom: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                ),
              ),
              child: TextFormField(
                controller: cubit.teacherPasswordController,
                obscureText: cubit.teacherObscure,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
                  hintText: S().password,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.teacherObscure = !cubit.teacherObscure;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onObscureChange();
                    },
                    icon: Icon(
                      cubit.teacherObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 35.r,
                      color: AppColors.primary,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 15.h),
        Text(
          S().subject,
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        SizedBox(height: 15.h),
        BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) => current is SelectChange,
          builder: (context, state) {
            return SegmentedButton(
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: "Math",
                  label: Text(
                    S().math,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
                ButtonSegment(
                  value: "English",
                  label: Text(
                    S().english,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
                ButtonSegment(
                  value: "Arabic",
                  label: Text(
                    S().arabic,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ],
              selected: cubit.teacherSubject,
              onSelectionChanged: (value) {
                cubit.teacherSubject = value;
                BlocProvider.of<AppManagerCubit>(context).onSelectChange();
              },
            );
          },
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton(
            onPressed: () {
              cubit.teacherRegister();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              S().continueQ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget therapistForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S().enterYourDetails,
          style: TextStyle(
            fontSize: 25.sp,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          controller: cubit.therapistEmailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          cursorColor: AppColors.primary,
          style: const TextStyle(
            fontFamily: AppFonts.mainFont,
          ),
          decoration: InputDecoration(
            hintText: S().emailAddress,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18.sp,
              fontFamily: AppFonts.mainFont,
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? AppColors.textFormFieldFillLight
                : AppColors.textFormFieldFillDark,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              borderSide: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 3.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              borderSide: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 3.w,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.textFormFieldFillLight
                : AppColors.textFormFieldFillDark,
            border: const Border(
              right: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
              left: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
              bottom: BorderSide(
                color: AppColors.textFormFieldBorder,
                width: 2.5,
              ),
            ),
          ),
          child: TextFormField(
            controller: cubit.therapistNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: AppColors.primary,
            style: const TextStyle(
              fontFamily: AppFonts.mainFont,
            ),
            decoration: InputDecoration(
              hintText: S().name,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18.sp,
                fontFamily: AppFonts.mainFont,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) => current is ObscureChange,
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.textFormFieldFillLight
                    : AppColors.textFormFieldFillDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                border: const Border(
                  right: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                  left: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                  bottom: BorderSide(
                    color: AppColors.textFormFieldBorder,
                    width: 2.5,
                  ),
                ),
              ),
              child: TextFormField(
                controller: cubit.therapistPasswordController,
                obscureText: cubit.therapistObscure,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
                  hintText: S().password,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.therapistObscure = !cubit.therapistObscure;
                      BlocProvider.of<AppManagerCubit>(context)
                          .onObscureChange();
                    },
                    icon: Icon(
                      cubit.therapistObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 35.r,
                      color: AppColors.primary,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton(
            onPressed: () {
              cubit.therapistRegister();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              S().continueQ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget avatar(String name) {
    return InkWell(
      onTap: () {
        cubit.childAvatar = name;
        BlocProvider.of<AppManagerCubit>(context).onSelectChange();
      },
      child: BlocBuilder<AppManagerCubit, AppManagerState>(
        buildWhen: (previous, current) => current is SelectChange,
        builder: (context, state) {
          return CircleAvatar(
            backgroundColor: cubit.childAvatar == name
                ? AppColors.secondary
                : Colors.transparent,
            radius: 50.r,
            child: Image.asset(
              name,
              width: 90.w,
            ),
          );
        },
      ),
    );
  }

  void onRegisterSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (cubit.userType == 'parent') {
            return const ParentHomeScreen();
          } else if (cubit.userType == 'teacher') {
            return const TeacherHomeScreen();
          } else if (cubit.userType == 'therapist') {
            return const TherapistHomeScreen();
          } else {
            return const Scaffold();
          }
        },
      ),
      (route) => false,
    );
  }
}
