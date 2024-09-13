import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/send_report/manager/send_report_cubit.dart';
import 'package:sen/features/send_report/manager/send_report_state.dart';
import 'package:sen/models/student.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:sen/utils/app_toast.dart';

class SendReportScreen extends StatefulWidget {
  final Student student;

  const SendReportScreen({
    super.key,
    required this.student,
  });

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  final cubit = SendReportCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.subjectController.dispose();
    cubit.contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<SendReportCubit, SendReportState>(
        listener: (context, state) {
          if (state is SendReportSuccess) {
            onSendReportSuccess();
          } else if (state is SendReportFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
              "Report",
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
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: cubit.subjectController,
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
                    "Content",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: TextFormField(
                      controller: cubit.contentController,
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
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.sentReport(widget.student);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        "SEND",
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

  void onSendReportSuccess() {
    displayToast("Report Sent");
    Navigator.pop(context);
  }
}
