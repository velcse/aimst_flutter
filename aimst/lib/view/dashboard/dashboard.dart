import 'package:flutter/material.dart';
import 'package:flutterapp/view/dashboard/authdashboard.dart';
import 'package:flutterapp/view/entrieslist/entrydashboard.dart';
import 'package:flutterapp/view/entrieslist/entrydashboardloundry.dart';
import 'package:flutterapp/view/profile/userprofiledetails.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';

import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutx/flutx.dart';
import 'package:flutterapp/widgets/appbar.dart';

String appTitleText = "";

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
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
      appBar: MyAppBar(appTitleText, false),
      backgroundColor: const Color(0xFFFFFFFF),
      endDrawer: const AppMenus(),
      body: FxBottomNavigationBar(
        containerDecoration: BoxDecoration(
          color: customTheme.card,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        activeContainerColor: customTheme.medicarePrimary.withAlpha(30),
        fxBottomNavigationBarType: FxBottomNavigationBarType.containered,
        showActiveLabel: false,
        showLabel: false,
        activeIconSize: 24,
        iconSize: 24,
        activeIconColor: customTheme.medicarePrimary,
        iconColor: theme.colorScheme.onBackground.withAlpha(140),
        itemList: [
          FxBottomNavigationBarItem(
            page: const AuthDashboard(),
            activeIconData: Icons.house,
            iconData: Icons.house_outlined,
          ),
          FxBottomNavigationBarItem(
            page: const EntryDashboard(),
            activeIconData: Icons.date_range,
            iconData: Icons.date_range_outlined,
          ),
          FxBottomNavigationBarItem(
            page: const LoundryEntryDashboard(),
            activeIconData: Icons.collections,
            iconData: Icons.collections,
          ),
          FxBottomNavigationBarItem(
            page: const UserProfile(),
            activeIconData: Icons.person,
            iconData: Icons.person_outline_rounded,
          ),
        ],
      ),
    );
  }
}
