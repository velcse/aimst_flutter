import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutterapp/widgets/text/text.dart';

import 'package:flutterapp/view/dashboard/dashboard.dart';
import 'package:flutterapp/view/entrieslist/entrydashboardpage.dart';
import 'package:flutterapp/view/entrieslist/entrydashboardloundrypage.dart';
import 'package:flutterapp/view/profile/userprofileinfopage.dart';
import 'package:flutterapp/view/login/login_form.dart';

import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutterapp/utils/spacing.dart';
import 'package:flutterapp/widgets/text/text.dart';
import 'package:flutterapp/widgets/container/container.dart';
import 'package:flutterapp/themes/text_style.dart';
import 'package:flutterapp/widgets/button/button.dart';
import 'package:flutterapp/localizations/en/constants.dart';
import 'package:flutterapp/utils/validators/form_validate.dart';
import 'package:flutterapp/blocs/user_bloc.dart';
import 'package:flutterapp/view/register/register_form.dart';
import 'package:flutterapp/view/dashboard/dashboard.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutterapp/animations/auth/tracking_text_input.dart';
import 'package:flutterapp/utils/images.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;

  // ignore: use_key_in_widget_constructors
  const MyAppBar(this.title, this.showBackArrow);

  @override
  Widget build(BuildContext context) {
    ThemeData theme;
    theme = AppTheme.theme;
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Row(children: <Widget>[
        (showBackArrow)
            ? GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onTap: () => Navigator.of(context).pop(),
              )
            : (Preference.getString(userToken) != null)
                ? GestureDetector(
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  )
                : const Text(""),
      ]),
      title: _titleWidget(),
    );
  }

  Widget _titleWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(color: Colors.black),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(54);
}

class AppMenus extends StatelessWidget implements PreferredSizeWidget {
  // ignore: use_key_in_widget_constructors
  const AppMenus();

  @override
  Widget build(BuildContext context) {
    ThemeData theme;
    theme = AppTheme.theme;
    return FxContainer.none(
      margin:
          FxSpacing.fromLTRB(16, FxSpacing.safeAreaTop(context) + 16, 16, 16),
      borderRadiusAll: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: theme.scaffoldBackgroundColor,
      child: Drawer(
          child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: FxSpacing.only(left: 20, bottom: 24, top: 24, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/images/aimst_logo.png'),
                    height: 102,
                    width: 102,
                  ),
                  FxSpacing.height(16),
                  FxContainer(
                    padding: FxSpacing.fromLTRB(12, 4, 12, 4),
                    borderRadiusAll: 4,
                    color: theme.colorScheme.primary.withAlpha(40),
                    child: FxText.bodyMedium(
                        "${Preference.getString(userFirstName)}\n${Preference.getString(userEmail)}",
                        color: theme.colorScheme.primary,
                        fontWeight: 600,
                        letterSpacing: 0.2),
                  ),
                ],
              ),
            ),
            FxSpacing.height(32),
            Container(
              margin: FxSpacing.x(20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserDashboard()));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          color: CustomTheme.occur.withAlpha(20),
                          child: Icon(
                            FeatherIcons.home,
                            size: 18,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.width(16),
                        Expanded(
                          child: FxText.bodyLarge(
                            'Home',
                          ),
                        ),
                        FxSpacing.width(16),
                        Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: theme.colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryDashboard()));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          color: CustomTheme.peach.withAlpha(20),
                          child: Icon(
                            FeatherIcons.frown,
                            size: 18,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.width(16),
                        Expanded(
                          child: FxText.bodyLarge(
                            'Cafetaria',
                          ),
                        ),
                        FxSpacing.width(16),
                        Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: theme.colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoundryEntryDashboard()));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          color: CustomTheme.peach.withAlpha(20),
                          child: Icon(
                            FeatherIcons.cornerLeftUp,
                            size: 18,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.width(16),
                        Expanded(
                          child: FxText.bodyLarge(
                            'Laundry',
                          ),
                        ),
                        FxSpacing.width(16),
                        Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: theme.colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserProfileInfoPage()));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          color: CustomTheme.peach.withAlpha(20),
                          child: Icon(
                            Icons.person,
                            size: 18,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        FxSpacing.width(16),
                        Expanded(
                          child: FxText.bodyLarge(
                            'Profile',
                          ),
                        ),
                        FxSpacing.width(16),
                        Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: theme.colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(20),
            Center(
              child: FxButton(
                borderRadiusAll: 4,
                elevation: 0,
                onPressed: () {
                  _logoutUser(context);
                },
                splashColor: theme.colorScheme.onPrimary.withAlpha(40),
                backgroundColor: theme.colorScheme.primary,
                child: FxText(
                  'Logout',
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

void _logoutUser(context) async {
  EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
      indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
  await Preference.init();
  await Preference.clear();
  await Preference.setString(contactEmail, "contact@aimstuniversity.com");
  await Preference.setString(siteName, "aimstuniversity.com");
  await Preference.setString(appTitle, "AIMST\nUNIVERSITY");
  EasyLoading.dismiss();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Login()));
}
