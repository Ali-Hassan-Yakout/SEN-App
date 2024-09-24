import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sen/features/levels/view/levels_screen.dart';
import 'package:sen/features/subjects/manager/subjects_cubit.dart';
import 'package:sen/features/subjects/manager/subjects_state.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SubjectsScreen extends StatefulWidget {
  final String screen;

  const SubjectsScreen({super.key, required this.screen});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final cubit = SubjectsCubit();

  @override
  void initState() {
    super.initState();
    cubit.getDifficulties();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<SubjectsCubit, SubjectsState>(
        buildWhen: (previous, current) => current is GetDifficultiesSuccess,
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.r),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.subjectTitles.length,
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LevelsScreen(
                                  screen: widget.screen,
                                  subject: cubit.subjectTitles[position],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(30.r),
                            margin: EdgeInsets.all(30.r),
                            decoration: BoxDecoration(
                              color: cubit.subjectColors[position],
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  cubit.subjectTitles[position],
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    color: cubit.subjectTitleColors[position],
                                    fontFamily: AppFonts.mainFont,
                                  ),
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                    cubit.subjectAnimations[position],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: cubit.pageController,
                    count: cubit.subjectTitles.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryBackground,
                      dotColor: AppColors.textFormFieldBorder,
                      dotHeight: 12.h,
                      dotWidth: 12.w,
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
