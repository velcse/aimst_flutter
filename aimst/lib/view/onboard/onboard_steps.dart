/*
* File : Shopping Onboarding
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/localizations/en/constants.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutx/flutx.dart';

import 'package:flutterapp/view/login/login_form.dart';

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
            body: Container(
                height: MediaQuery.of(context).size.height,
                color: theme.backgroundColor,
                child: FxOnBoarding(
                  pages: <PageViewModel>[
                    PageViewModel(
                      theme.backgroundColor,
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Center(
                                child: Image(
                              image: AssetImage(
                                  './assets/images/illustration/shopping/illu-1.png'),
                              width: 300,
                              height: 320,
                            )),
                            const SizedBox(height: 30),
                            FxText.bodyLarge(onBoardingSubTitleOne,
                                fontWeight: 700),
                            const SizedBox(height: 16),
                            FxText(onBoardingInfoOne, fontWeight: 500),
                          ],
                        ),
                      ),
                    ),
                    PageViewModel(
                      theme.backgroundColor,
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Center(
                                child: Image(
                              image: AssetImage(
                                  './assets/images/illustration/shopping/illu-2.png'),
                              width: 300,
                              height: 320,
                            )),
                            const SizedBox(height: 30),
                            FxText.bodyLarge(onBoardingSubTitleTwo,
                                fontWeight: 700),
                            const SizedBox(height: 16),
                            FxText.bodyMedium(onBoardingInfoTwo,
                                fontWeight: 500)
                          ],
                        ),
                      ),
                    ),
                    PageViewModel(
                      theme.backgroundColor,
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Center(
                                child: Image(
                              image: AssetImage(
                                  './assets/images/illustration/shopping/illu-3.png'),
                              width: 300,
                              height: 320,
                            )),
                            const SizedBox(height: 30),
                            FxText.bodyLarge('Activity Logs', fontWeight: 700),
                            const SizedBox(height: 16),
                            FxText.bodyMedium(
                                'You can check your activity logs once logged into system',
                                fontWeight: 500),
                          ],
                        ),
                      ),
                    ),
                  ],
                  unSelectedIndicatorColor:
                      theme.colorScheme.primary.withAlpha(150),
                  selectedIndicatorColor: theme.colorScheme.primary,
                  doneWidget: InkWell(
                    splashColor: theme.colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: FxText.titleSmall("DONE".toUpperCase(),
                          fontWeight: 700, color: theme.colorScheme.primary),
                    ),
                  ),
                  skipWidget: InkWell(
                    splashColor: theme.colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: FxText.titleSmall("Skip".toUpperCase(),
                          color: theme.colorScheme.primary,
                          fontWeight: 700,
                          letterSpacing: 0.6),
                    ),
                  ),
                ))));
  }
}
