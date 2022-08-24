import 'package:flutter/material.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/theme/constant.dart';
import 'package:flutterapp/utils/spacing.dart';
import 'package:flutterapp/widgets/text/text.dart';
import 'package:flutterapp/widgets/container/container.dart';
import 'package:flutterapp/widgets/button/button.dart';
import 'package:flutterapp/view/login/login_form.dart';
import 'package:flutterapp/widgets/appbar.dart';
import 'package:flutterapp/view/profile/userprofileinfo.dart';

String appTitleText = "";
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _GetUserProfileState createState() => _GetUserProfileState();
}

class _GetUserProfileState extends State<UserProfile> {
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
      appBar: const MyAppBar("Profile", true),
      backgroundColor: const Color(0xFFFFFFFF),
      drawer: const AppMenus(),
      body: SingleChildScrollView(
        child: Padding(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              FxSpacing.height(20),
              settings(),
              FxSpacing.height(16),
              logout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget image() {
    return const Center(
      child: FxContainer.rounded(
        height: 100,
        paddingAll: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('./assets/images/profile/avatar_place.png'),
        ),
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

  Widget settings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.bodyMedium(
          "Account Settings",
          fontWeight: 700,
          xMuted: true,
        ),
        FxSpacing.height(20),
        GestureDetector(
          child: singleRow(Icons.dashboard, "Profile", "Your profile details"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileInfo()));
          },
        ),
        const Divider(),
        FxSpacing.height(8),
        singleRow(Icons.location_on, "Address", "Your address details"),
        const Divider(),
        FxSpacing.height(8),
        singleRow(
            Icons.admin_panel_settings, "Privcy", "Your account login details"),
        const Divider(),
        FxSpacing.height(8),
        singleRow(Icons.redeem, "Academic", "Manage your academic detils"),
      ],
    );
  }

  Widget singleRow(IconData icon, String title, String subTitle) {
    return Padding(
      padding: FxSpacing.bottom(8),
      child: Row(
        children: [
          FxContainer.rounded(
            paddingAll: 12,
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          FxSpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium(
                  title,
                  fontWeight: 600,
                ),
                FxSpacing.height(2),
                FxText.bodySmall(subTitle),
              ],
            ),
          ),
          FxSpacing.width(20),
          const Icon(
            Icons.arrow_forward,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget logout() {
    return Align(
      alignment: Alignment.center,
      child: FxButton.small(
        elevation: 0,
        onPressed: () {
          _logoutUser(context);
        },
        borderRadiusAll: Constant.buttonRadius.xs,
        padding: FxSpacing.xy(16, 8),
        child: FxText.labelLarge(
          "Logout",
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}

void _logoutUser(context) async {
  EasyLoading.show(
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
