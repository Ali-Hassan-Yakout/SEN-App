import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/features/all_reports/manager/all_reports_cubit.dart';
import 'package:sen/features/all_reports/manager/all_reports_state.dart';
import 'package:sen/features/report_read/view/report_read_screen.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class AllReportsScreen extends StatefulWidget {
  const AllReportsScreen({super.key});

  @override
  State<AllReportsScreen> createState() => _AllReportsScreenState();
}

class _AllReportsScreenState extends State<AllReportsScreen> {
  final cubit = AllReportsCubit();

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
        body: allReportItemBuilder(),
      ),
    );
  }

  Widget allReportItemBuilder() {
    return BlocBuilder<AllReportsCubit, AllReportsState>(
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
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.textFormFieldFillDark,
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
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: AppColors.primaryBackground,
                          child: cubit.reports[index].image.isEmpty
                              ? Text(
                                  cubit.reports[index].name[0],
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: AppFonts.mainFont,
                                  ),
                                )
                              : Image.network(cubit.reports[index].image),
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
                                  fontWeight: FontWeight.w800,
                                  fontFamily: AppFonts.mainFont,
                                ),
                              ),
                              Text(
                                cubit.reports[index].lastReportSubject,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.textGrey,
                                  fontWeight: FontWeight.w800,
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
