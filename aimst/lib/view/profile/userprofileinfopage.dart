import 'package:flutter/material.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutterapp/utils/spacing.dart';
import 'package:flutterapp/widgets/text/text.dart';
import 'package:flutterapp/widgets/container/container.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/models/activitylogs_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutterapp/widgets/appbar.dart';
import 'package:flutterapp/theme/constant.dart';

String appTitleText = "";
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class UserProfileInfoPage extends StatefulWidget {
  const UserProfileInfoPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetUserProfileInfoPageState createState() => _GetUserProfileInfoPageState();
}

class _GetUserProfileInfoPageState extends State<UserProfileInfoPage> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    appTitleText = Preference.getString(appTitle)!;
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar('Profile Details', false),
        backgroundColor: const Color(0xFFFFFFFF),
        drawer: const AppMenus(),
        body: ListView(padding: FxSpacing.fromLTRB(24, 18, 24, 24), children: [
          image(),
          FxSpacing.height(4),
          Align(
              alignment: Alignment.center,
              child: FxText.titleMedium(
                Preference.getString(userFirstName).toString(),
                fontWeight: 700,
              )),
          FxSpacing.height(4),
          verified(),
          SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: <Widget>[
                      _TransactionWidget(
                          name: Preference.getString(userFirstName).toString(),
                          date: "First Name",
                          amount: 177,
                          isSend: false),
                      const Divider(
                        height: 0,
                      ),
                      _TransactionWidget(
                          name: Preference.getString(userLastName).toString(),
                          date: "Last Name",
                          amount: 99,
                          isSend: true),
                      const Divider(
                        height: 0,
                      ),
                      _TransactionWidget(
                          name: Preference.getString(userEmail).toString(),
                          date: "Email Address",
                          amount: 100,
                          isSend: true),
                      const Divider(
                        height: 0,
                      ),
                      _TransactionWidget(
                          name: Preference.getString(matrixNumber).toString(),
                          date: "Matrix Number",
                          amount: 160,
                          isSend: true),
                      const Divider(
                        height: 0,
                      ),
                      _TransactionWidget(
                          name: Preference.getString(icNumber).toString(),
                          date: "Ic Number",
                          amount: 19,
                          isSend: true),
                      const Divider(
                        height: 0,
                      ),
                    ],
                  )))
        ]));
  }

  Widget image() {
    return Center(
      child: FxContainer.rounded(
        height: 100,
        paddingAll: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.network(Preference.getString(userProfilePic).toString(),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget verified() {
    return Align(
      alignment: Alignment.center,
      child: FxContainer(
        padding: FxSpacing.fromLTRB(6, 4, 12, 4),
        borderRadiusAll: Constant.containerRadius.large,
        color: theme.colorScheme.primaryContainer,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: theme.colorScheme.onPrimaryContainer,
              size: 16,
            ),
            FxSpacing.width(8),
            FxText.bodySmall(
              "Verified",
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: 600,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionWidget extends StatefulWidget {
  final bool isSend;
  final String name, date;
  final int amount;

  _TransactionWidget(
      {Key? key,
      this.isSend = false,
      required this.name,
      required this.date,
      required this.amount})
      : super(key: key);

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<_TransactionWidget> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FxText.titleMedium(widget.name,
                        fontWeight: 600, letterSpacing: 0),
                    FxText.bodySmall(widget.date, fontWeight: 500),
                  ],
                ),
              ),
            ),
            /*Row(
              children: <Widget>[
                FxText.titleMedium(
                  widget.isSend ? "- " : "+ ",
                ),
                FxText.titleMedium("\$ ${widget.amount}", fontWeight: 600),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
