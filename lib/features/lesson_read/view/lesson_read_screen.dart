import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/models/lesson.dart';
import 'package:sen/utils/app_colors.dart';
import 'package:sen/utils/app_fonts.dart';

class LessonReadScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonReadScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonReadScreen> createState() => _LessonReadScreenState();
}

class _LessonReadScreenState extends State<LessonReadScreen> {
  late CachedVideoPlayerController videoPlayerController;
  late CustomVideoPlayerController customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.r,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          widget.lesson.title,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: CustomVideoPlayer(
                customVideoPlayerController: customVideoPlayerController,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "${S().description} :",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.lesson.description,
              style: TextStyle(
                fontSize: 18.sp,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.textGrey
                    : Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initVideoPlayer() {
    videoPlayerController =
        CachedVideoPlayerController.network(widget.lesson.url)
          ..initialize().then((value) => setState(() {}));
    customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }
}
