import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/models/report.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class ReportReadScreen extends StatefulWidget {
  final Report report;

  const ReportReadScreen({super.key, required this.report});

  @override
  State<ReportReadScreen> createState() => _ReportReadScreenState();
}

class _ReportReadScreenState extends State<ReportReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: reportItemBuilder(),
    );
  }

  Widget reportItemBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.report.reports.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(15.r),
        margin: EdgeInsets.only(
          top: 15.h,
          left: 15.w,
          right: 15.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.textFormFieldBorder,
            width: 2.5.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.report.reports[index].date.split(' ')[0],
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
            ),
            Text(
              "Subject : ${widget.report.reports[index].subject}",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            Divider(
              color: AppColors.textFormFieldBorder,
              thickness: 2.5.w,
            ),
            Text(
              widget.report.reports[index].content,
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.textGrey,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
