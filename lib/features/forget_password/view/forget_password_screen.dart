import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/forget_password/manager/forget_password_cubit.dart';
import 'package:sen/features/forget_password/manager/forget_password_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final cubit = ForgetPasswordCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            onResetPasswordSuccess();
          } else if (state is ResetPasswordFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: 0.h,
                bottom: 15.h,
                left: 15.w,
                right: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/forget_password.json",
                    width: 250.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "Enter your email address to receive a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: cubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    cursorColor: AppColors.primary,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                        fontFamily: AppFonts.mainFont,
                      ),
                      filled: true,
                      fillColor: AppColors.textFormFieldFill,
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
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.resetPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onResetPasswordSuccess() {
    displayToast("Check your inbox");
    Navigator.pop(context);
  }
}
