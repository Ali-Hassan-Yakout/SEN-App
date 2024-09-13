import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/database/shared_preferences.dart';
import 'package:sen/features/app_manager/app_manager_cubit.dart';
import 'package:sen/features/app_manager/app_manager_state.dart';
import 'package:sen/features/forget_password/view/forget_password_screen.dart';
import 'package:sen/features/login/manager/login_cubit.dart';
import 'package:sen/features/login/manager/login_state.dart';
import 'package:sen/features/parent_home/view/parent_home_screen.dart';
import 'package:sen/features/teacher_home/view/teacher_home_screen.dart';
import 'package:sen/features/therapist_home/view/therapist_home_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final cubit = LoginCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.emailController.dispose();
    cubit.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            onLoginSuccess();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
            title: LinearProgressIndicator(
              color: AppColors.secondary,
              backgroundColor: AppColors.textFormFieldBorder,
              minHeight: 15.h,
              borderRadius: BorderRadius.circular(16.r),
              value: cubit.progress,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Enter your details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: cubit.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColors.primary,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.mainFont,
                  ),
                  decoration: InputDecoration(
                    hintText: "SEN username or email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                    filled: true,
                    fillColor: AppColors.textFormFieldFill,
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
                BlocBuilder<AppManagerCubit, AppManagerState>(
                  buildWhen: (previous, current) => current is ObscureChange,
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFormFieldFill,
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
                        controller: cubit.passwordController,
                        obscureText: cubit.obscure,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        cursorColor: AppColors.primary,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: AppFonts.mainFont,
                        ),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.sp,
                            fontFamily: AppFonts.mainFont,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.obscure = !cubit.obscure;
                              BlocProvider.of<AppManagerCubit>(context)
                                  .onObscureChange();
                            },
                            icon: Icon(
                              cubit.obscure
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
                SizedBox(height: 10.h),
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (previous, current) => current is LoginFailure,
                  builder: (context, state) {
                    return Visibility(
                      visible: cubit.errorMessage.isNotEmpty,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cubit.errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "FORGOT PASSWORD",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "By signing in to SEN, you agree to our ",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "Terms ",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 17.sp,
                          fontFamily: AppFonts.mainFont,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: "and ",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
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
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onLoginSuccess() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (PreferenceUtils.getString(PrefKeys.userType) == 'parent') {
            return const ParentHomeScreen();
          } else if (PreferenceUtils.getString(PrefKeys.userType) ==
              'teacher') {
            return const TeacherHomeScreen();
          } else if (PreferenceUtils.getString(PrefKeys.userType) ==
              'therapist') {
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
