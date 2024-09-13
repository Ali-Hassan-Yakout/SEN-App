import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/intro/view/intro_screen.dart';
import 'package:sen/features/settings/manager/settings_cubit.dart';
import 'package:sen/features/settings/manager/settings_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final cubit = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            onSignOutSuccess();
          } else if (state is SignOutFailure) {
            displayToast(state.errorMessage);
          } else if (state is DeleteProfileSuccess) {
            onDeleteProfileSuccess();
          } else if (state is DeleteProfileFailure) {
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
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.deleteProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(
                          color: AppColors.textFormFieldBorder,
                          width: 2.5.w,
                        ),
                      ),
                    ),
                    child: Text(
                      "DELETE PROFILE",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.sp,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "SIGN OUT",
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
    );
  }

  void onSignOutSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const IntroScreen(),
      ),
      (route) => false,
    );
  }

  void onDeleteProfileSuccess() {
    displayToast("We hate good-byes.");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const IntroScreen(),
      ),
      (route) => false,
    );
  }
}
