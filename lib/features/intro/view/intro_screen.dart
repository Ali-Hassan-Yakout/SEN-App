import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/login/view/login_screen.dart';
import 'package:sen/features/register/view/register_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 15.w,
            left: 15.w,
            top: 150.h,
            bottom: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/intro.json",
                width: 250.w,
                fit: BoxFit.fitWidth,
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  "The most fun way to learn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 28.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  "HAVE AN ACCOUNT? LOG IN",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
