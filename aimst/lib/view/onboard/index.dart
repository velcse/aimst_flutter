import 'package:flutter/material.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutx/flutx.dart';
import 'package:flutterapp/localizations/en/constants.dart';
import 'package:flutterapp/view/login/login_form.dart';
import 'package:flutterapp/utils/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(
            textDirection: AppTheme.textDirection,
            child: child!,
          );
        },
        home: Scaffold(
            body: SingleChildScrollView(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxContainer(
                padding: FxSpacing.xy(48, 20),
                color: theme.colorScheme.primaryContainer,
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  fit: BoxFit.fill,
                  height: 300,
                  image: AssetImage(Images.shoppingSplash),
                ),
              ),
              FxSpacing.height(40),
              FxText.displaySmall(
                onBoardingTitle,
                fontWeight: 700,
                textAlign: TextAlign.center,
              ),
              FxSpacing.height(20),
              FxText.displaySmall(
                onBoardingSubTitleOne,
                fontSize: 14,
                fontWeight: 500,
                textAlign: TextAlign.left,
              ),
              FxSpacing.height(10),
              FxText.bodyMedium(
                onBoardingInfoOne,
                xMuted: true,
                textAlign: TextAlign.left,
              ),
              FxSpacing.height(20),
              FxText.displaySmall(
                onBoardingSubTitleTwo,
                fontSize: 14,
                fontWeight: 500,
                textAlign: TextAlign.left,
              ),
              FxSpacing.height(10),
              FxText.bodyMedium(
                onBoardingInfoTwo,
                xMuted: true,
                textAlign: TextAlign.left,
              ),
              FxText.displaySmall(
                onBoardingSubTitleThree,
                fontSize: 14,
                fontWeight: 500,
                textAlign: TextAlign.left,
              ),
              FxSpacing.height(10),
              FxText.bodyMedium(
                onBoardingInfoThree,
                xMuted: true,
                textAlign: TextAlign.left,
              ),
              FxSpacing.height(40),
              FxButton.block(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                backgroundColor: theme.colorScheme.primary,
                elevation: 0,
                borderRadiusAll: 4,
                child: FxText.labelLarge(
                  getStartButtonText,
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        )));
  }
}
