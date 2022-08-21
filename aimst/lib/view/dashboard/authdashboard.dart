import 'package:flutter/material.dart';
import 'package:flutterapp/blocs/user_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/widgets/error_message_widget.dart' as _error;
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutterapp/view/login/login_form.dart';
import 'package:flutterapp/localizations/en/constants.dart';

import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutterapp/utils/spacing.dart';
import 'package:flutterapp/widgets/text/text.dart';
import 'package:flutterapp/widgets/container/container.dart';
import 'package:flutterapp/widgets/button/button.dart';

String appTitleText = "";
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class AuthDashboard extends StatefulWidget {
  const AuthDashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetAuthDashboardState createState() => _GetAuthDashboardState();
}

class _GetAuthDashboardState extends State<AuthDashboard> {
  late UserBloc _bloc;
  late ThemeData theme;
  int seconds = 0;
  int authTotken = 0;
  bool tokenGenerated = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc();
    theme = AppTheme.theme;
    appTitleText = Preference.getString(appTitle)!;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds = seconds - 1;
        } else if (tokenGenerated) {
          timer.cancel();
          tokenGenerated = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: MyAppBar(appTitleText, false),
        backgroundColor: const Color(0xFFFFFFFF),
        endDrawer: const AppMenus(),
        body: ListView(
          padding: FxSpacing.fromLTRB(16, 25, 16, 16),
          children: <Widget>[
            FxText.displaySmall(
              "Hello ${Preference.getString(userFirstName)}! \nWelcome back to Aimst Student Portal.",
              fontWeight: 600,
              fontSize: 25,
              color: theme.colorScheme.primary,
            ),
            _CardWidget(),
          ],
        ));
  }

  // ignore: non_constant_identifier_names
  Widget _CardWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: PageController(initialPage: 1, viewportFraction: 1),
        children: <Widget>[
          FxContainer.bordered(
            margin:
                const EdgeInsets.only(left: 0, top: 20, bottom: 24, right: 8),
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FxText.headlineSmall("Generate entry pass here to authenticate",
                    fontWeight: 700, color: Colors.black),
                (seconds > 0)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.labelSmall("",
                              fontWeight: 600, color: Colors.black),
                          FxText.titleLarge(
                              (authTotken == 0)
                                  ? "Generating token......."
                                  : authTotken.toString(),
                              fontWeight: 700,
                              letterSpacing: 0.3,
                              color: Colors.black),
                        ],
                      )
                    : Container(
                        margin:
                            const EdgeInsets.only(left: 24, right: 24, top: 36),
                        child: FxButton(
                            elevation: 0,
                            padding: FxSpacing.y(12),
                            borderRadiusAll: 4,
                            onPressed: () {
                              generateAuthKey();
                            },
                            child: Center(
                              child: FxText.bodyMedium("GENERATE TOKEN",
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.8,
                                  fontWeight: 700),
                            ))),
                (seconds > 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FxText.bodyMedium(
                              "Token will be expiry in 30 seconds",
                              fontWeight: 600,
                              letterSpacing: 0.3,
                              color: Colors.black),
                          FxText.bodyLarge(seconds.toString(),
                              fontWeight: 700, color: Colors.black),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future generateAuthKey() async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.generateAuthKey();
      if (response['status'] == true) {
        setState(() {
          authTotken = response['result']['authkey'];
          seconds = 30;
          errorMessage = '';
          tokenGenerated = true;
        });
      } else if (response['status'] == false) {
        setState(() {
          errorMessage = response['message'];
        });
      } else {
        setState(() {
          errorMessage = apiError;
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      errorMessage = apiError;
      EasyLoading.dismiss();
    }
  }
}
