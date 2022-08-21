import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppConstants extends InheritedWidget {
  AppConstants({Key? key, required super.child}) : super(key: key);

  final String successMessage = 'Some message';

  // Static texts for applications
  static String onBoardingTitle = "Aimst Student Managment";
  static String onBoardingTitleEn = "Aimst Student Managment En";
  static String onBoardingSubTitleOne = "Student account";
  static String onBoardingInfoOne =
      "Authenticate for entry into systems.If you dont have account please register andget approval from autharized person";
  static String onBoardingSubTitleTow = "How to system work?";
  static String onBoardingInfoTwo =
      "While entering into Library,laundry or Food court etc.. You can genarate unique number and get the access from security.',";
  static String onBoardingSubTitleThree = "Activity Logs";
  static String onBoardingInfoThree =
      "You can check your activity logs once logged into system";

  Map<String, String> en = {"onBoardingTitle": "Aimst Student Managment"};

  @override
  bool updateShouldNotify(AppConstants oldWidget) => false;

  static of(BuildContext context) {}
}
