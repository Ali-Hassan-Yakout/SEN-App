import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_students/view/all_students_screen.dart';
import 'package:sen/features/report_control/manager/report_control_cubit.dart';
import 'package:sen/features/report_control/manager/report_control_state.dart';
import 'package:sen/features/report_read/view/report_read_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class ReportControlScreen extends StatefulWidget {
  const ReportControlScreen({super.key});

  @override
  State<ReportControlScreen> createState() => _ReportControlScreenState();
}

class _ReportControlScreenState extends State<ReportControlScreen> {
  final cubit = ReportControlCubit();

  @override
  void initState() {
    super.initState();
    cubit.getReports();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllStudentsScreen(),
                  ),
                ).then((value) {
                  cubit.getReports();
                });
              },
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.message_rounded,
                size: 35.r,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
        body: allReportItemBuilder(),
      ),
    );
  }

  Widget allReportItemBuilder() {
    return BlocBuilder<ReportControlCubit, ReportControlState>(
      buildWhen: (previous, current) => current is GetReportSuccess,
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.reports.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportReadScreen(
                      report: cubit.reports[index],
                    ),
                  ),
                );
              },
              child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cubit.reports[index].lastReportDate.split(' ')[0],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColors.primaryBackground,
                          child: cubit.reports[index].image.isEmpty
                              ? Text(
                                  cubit.reports[index].name[0],
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontFamily: AppFonts.mainFont,
                                  ),
                                )
                              : Image.asset(cubit.reports[index].image),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.reports[index].name,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontFamily: AppFonts.mainFont,
                                ),
                              ),
                              Text(
                                cubit.reports[index].lastReportSubject,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.textGrey,
                                  fontFamily: AppFonts.mainFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
