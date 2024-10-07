// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `The most fun way to learn`
  String get theMostFunWayToLearn {
    return Intl.message(
      'The most fun way to learn',
      name: 'theMostFunWayToLearn',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `HAVE AN ACCOUNT? LOG IN`
  String get haveAnAccountLogIn {
    return Intl.message(
      'HAVE AN ACCOUNT? LOG IN',
      name: 'haveAnAccountLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details`
  String get enterYourDetails {
    return Intl.message(
      'Enter your details',
      name: 'enterYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `SEN username or email`
  String get senUsernameOrEmail {
    return Intl.message(
      'SEN username or email',
      name: 'senUsernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get signIn {
    return Intl.message(
      'SIGN IN',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `FORGOT PASSWORD`
  String get forgetPassword {
    return Intl.message(
      'FORGOT PASSWORD',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `By signing in to SEN, you agree to our `
  String get bySigning {
    return Intl.message(
      'By signing in to SEN, you agree to our ',
      name: 'bySigning',
      desc: '',
      args: [],
    );
  }

  /// `Terms `
  String get terms {
    return Intl.message(
      'Terms ',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `and `
  String get and {
    return Intl.message(
      'and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPasswordQ {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPasswordQ',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to receive a link to reset your password.`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email address to receive a link to reset your password.',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get submit {
    return Intl.message(
      'SUBMIT',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Check your inbox`
  String get checkYourInbox {
    return Intl.message(
      'Check your inbox',
      name: 'checkYourInbox',
      desc: '',
      args: [],
    );
  }

  /// `Email can't be blank`
  String get emailCantBeBlank {
    return Intl.message(
      'Email can\'t be blank',
      name: 'emailCantBeBlank',
      desc: '',
      args: [],
    );
  }

  /// `Try again later`
  String get tryAgainLater {
    return Intl.message(
      'Try again later',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet!`
  String get checkYourInternet {
    return Intl.message(
      'Check your internet!',
      name: 'checkYourInternet',
      desc: '',
      args: [],
    );
  }

  /// `Who Are You?`
  String get whoAreYou {
    return Intl.message(
      'Who Are You?',
      name: 'whoAreYou',
      desc: '',
      args: [],
    );
  }

  /// `Please choose your role to continue.`
  String get pleaseChooseYourRole {
    return Intl.message(
      'Please choose your role to continue.',
      name: 'pleaseChooseYourRole',
      desc: '',
      args: [],
    );
  }

  /// `Teacher`
  String get teacher {
    return Intl.message(
      'Teacher',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `Therapist`
  String get therapist {
    return Intl.message(
      'Therapist',
      name: 'therapist',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get parent {
    return Intl.message(
      'Parent',
      name: 'parent',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get thePasswordProvided {
    return Intl.message(
      'The password provided is too weak.',
      name: 'thePasswordProvided',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get theAccountAlready {
    return Intl.message(
      'The account already exists for that email.',
      name: 'theAccountAlready',
      desc: '',
      args: [],
    );
  }

  /// `Details can't be blank`
  String get detailsCantBeBlank {
    return Intl.message(
      'Details can\'t be blank',
      name: 'detailsCantBeBlank',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Math`
  String get math {
    return Intl.message(
      'Math',
      name: 'math',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Therapy`
  String get therapy {
    return Intl.message(
      'Therapy',
      name: 'therapy',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get continueQ {
    return Intl.message(
      'CONTINUE',
      name: 'continueQ',
      desc: '',
      args: [],
    );
  }

  /// `How did you hear about SEN?`
  String get howDidYouHearAboutSEN {
    return Intl.message(
      'How did you hear about SEN?',
      name: 'howDidYouHearAboutSEN',
      desc: '',
      args: [],
    );
  }

  /// `Facebook/Instagram`
  String get facebookInstagram {
    return Intl.message(
      'Facebook/Instagram',
      name: 'facebookInstagram',
      desc: '',
      args: [],
    );
  }

  /// `YouTube`
  String get youTube {
    return Intl.message(
      'YouTube',
      name: 'youTube',
      desc: '',
      args: [],
    );
  }

  /// `Teacher/school`
  String get teacherSchool {
    return Intl.message(
      'Teacher/school',
      name: 'teacherSchool',
      desc: '',
      args: [],
    );
  }

  /// `Friends/family`
  String get friendsFamily {
    return Intl.message(
      'Friends/family',
      name: 'friendsFamily',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Create an account to track your child's progress`
  String get createAnAccountToTrack {
    return Intl.message(
      'Create an account to track your child\'s progress',
      name: 'createAnAccountToTrack',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get createAPassword {
    return Intl.message(
      'Create a password',
      name: 'createAPassword',
      desc: '',
      args: [],
    );
  }

  /// `Are you a grown-up?`
  String get areYouAGrownUp {
    return Intl.message(
      'Are you a grown-up?',
      name: 'areYouAGrownUp',
      desc: '',
      args: [],
    );
  }

  /// `We want to keep kids safe! Only an adult should create an account.`
  String get weWantToKeepKidsSafe {
    return Intl.message(
      'We want to keep kids safe! Only an adult should create an account.',
      name: 'weWantToKeepKidsSafe',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `What is your child's name?`
  String get whatIsYourChildName {
    return Intl.message(
      'What is your child\'s name?',
      name: 'whatIsYourChildName',
      desc: '',
      args: [],
    );
  }

  /// `They'll learn how to write it themselves!`
  String get theyLearnHowToWriteItThemselves {
    return Intl.message(
      'They\'ll learn how to write it themselves!',
      name: 'theyLearnHowToWriteItThemselves',
      desc: '',
      args: [],
    );
  }

  /// `How old is `
  String get howOldIs {
    return Intl.message(
      'How old is ',
      name: 'howOldIs',
      desc: '',
      args: [],
    );
  }

  /// `?`
  String get questionMark {
    return Intl.message(
      '?',
      name: 'questionMark',
      desc: '',
      args: [],
    );
  }

  /// `We'll personalize the experience for this age.`
  String get wePersonalizeTheExperienceForThisAge {
    return Intl.message(
      'We\'ll personalize the experience for this age.',
      name: 'wePersonalizeTheExperienceForThisAge',
      desc: '',
      args: [],
    );
  }

  /// `In Which Grade`
  String get inWhichGrade {
    return Intl.message(
      'In Which Grade',
      name: 'inWhichGrade',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get grade {
    return Intl.message(
      'Grade',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `We'll personalize the experience for this grade.`
  String get wePersonalizeTheExperienceForThisGrade {
    return Intl.message(
      'We\'ll personalize the experience for this grade.',
      name: 'wePersonalizeTheExperienceForThisGrade',
      desc: '',
      args: [],
    );
  }

  /// `Which difficulties face`
  String get whichDifficultiesFace {
    return Intl.message(
      'Which difficulties face',
      name: 'whichDifficultiesFace',
      desc: '',
      args: [],
    );
  }

  /// `We'll personalize the experience for these difficulties.`
  String get wePersonalizeTheExperienceForTheseDifficulties {
    return Intl.message(
      'We\'ll personalize the experience for these difficulties.',
      name: 'wePersonalizeTheExperienceForTheseDifficulties',
      desc: '',
      args: [],
    );
  }

  /// `Conduct disorder`
  String get conductDisorder {
    return Intl.message(
      'Conduct disorder',
      name: 'conductDisorder',
      desc: '',
      args: [],
    );
  }

  /// `Learning difficulties`
  String get learningDifficulties {
    return Intl.message(
      'Learning difficulties',
      name: 'learningDifficulties',
      desc: '',
      args: [],
    );
  }

  /// `Choose an avatar for`
  String get chooseAnAvatarFor {
    return Intl.message(
      'Choose an avatar for',
      name: 'chooseAnAvatarFor',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message(
      'Subjects',
      name: 'subjects',
      desc: '',
      args: [],
    );
  }

  /// `Quizzes`
  String get quizzes {
    return Intl.message(
      'Quizzes',
      name: 'quizzes',
      desc: '',
      args: [],
    );
  }

  /// `Grades`
  String get grades {
    return Intl.message(
      'Grades',
      name: 'grades',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get quizGrade {
    return Intl.message(
      'Grade',
      name: 'quizGrade',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `DELETE PROFILE`
  String get deleteProfile {
    return Intl.message(
      'DELETE PROFILE',
      name: 'deleteProfile',
      desc: '',
      args: [],
    );
  }

  /// `SIGN OUT`
  String get signOut {
    return Intl.message(
      'SIGN OUT',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `We hate good-byes`
  String get weHateGoodByes {
    return Intl.message(
      'We hate good-byes',
      name: 'weHateGoodByes',
      desc: '',
      args: [],
    );
  }

  /// `Levels`
  String get levels {
    return Intl.message(
      'Levels',
      name: 'levels',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message(
      'Lessons',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `MR`
  String get mr {
    return Intl.message(
      'MR',
      name: 'mr',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subjectR {
    return Intl.message(
      'Subject',
      name: 'subjectR',
      desc: '',
      args: [],
    );
  }

  /// `Email or password can't be blank`
  String get emailOrPasswordCantBeBlank {
    return Intl.message(
      'Email or password can\'t be blank',
      name: 'emailOrPasswordCantBeBlank',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Credentials!`
  String get invalidCredentials {
    return Intl.message(
      'Invalid Credentials!',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Answers`
  String get answers {
    return Intl.message(
      'Answers',
      name: 'answers',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this lesson?`
  String get areYouSureLesson {
    return Intl.message(
      'Are you sure you want to delete this lesson?',
      name: 'areYouSureLesson',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Edit Lesson`
  String get editLesson {
    return Intl.message(
      'Edit Lesson',
      name: 'editLesson',
      desc: '',
      args: [],
    );
  }

  /// `Add Lesson`
  String get addLesson {
    return Intl.message(
      'Add Lesson',
      name: 'addLesson',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD`
  String get upload {
    return Intl.message(
      'UPLOAD',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `ATTACH`
  String get attach {
    return Intl.message(
      'ATTACH',
      name: 'attach',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this quiz?`
  String get areYouSureQuiz {
    return Intl.message(
      'Are you sure you want to delete this quiz?',
      name: 'areYouSureQuiz',
      desc: '',
      args: [],
    );
  }

  /// `QUESTION`
  String get questionU {
    return Intl.message(
      'QUESTION',
      name: 'questionU',
      desc: '',
      args: [],
    );
  }

  /// `Add Quiz`
  String get addQuiz {
    return Intl.message(
      'Add Quiz',
      name: 'addQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Students`
  String get students {
    return Intl.message(
      'Students',
      name: 'students',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `SEND`
  String get send {
    return Intl.message(
      'SEND',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Report Sent`
  String get reportSent {
    return Intl.message(
      'Report Sent',
      name: 'reportSent',
      desc: '',
      args: [],
    );
  }

  /// `Image upload failed`
  String get imageUploadFailed {
    return Intl.message(
      'Image upload failed',
      name: 'imageUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Quiz upload failed`
  String get quizUploadFailed {
    return Intl.message(
      'Quiz upload failed',
      name: 'quizUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Quiz Uploaded`
  String get quizUploaded {
    return Intl.message(
      'Quiz Uploaded',
      name: 'quizUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Video upload failed`
  String get videoUploadFailed {
    return Intl.message(
      'Video upload failed',
      name: 'videoUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Lesson upload failed`
  String get lessonUploadFailed {
    return Intl.message(
      'Lesson upload failed',
      name: 'lessonUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Lesson Uploaded`
  String get lessonUploaded {
    return Intl.message(
      'Lesson Uploaded',
      name: 'lessonUploaded',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
