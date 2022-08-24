import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/widgets/error_message_widget.dart' as error;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/theme/constant.dart';
import 'package:flutterapp/widgets/appbar.dart';
import 'dart:async';

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

String appTitleText = "";
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetLoginState createState() => _GetLoginState();
}

class _GetLoginState extends State<Login> {
  late UserBloc _bloc;
  late ThemeData theme;
  late OutlineInputBorder outlineInputBorder;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc();
    theme = AppTheme.theme;
    appTitleText = Preference.getString(appTitle)!;
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.textFieldRadius.medium)),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  Future userLogin([email, password]) async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.loginUser(email, password);
      if (response['status'] == true) {
        setState(() {
          errorMessage = '';
        });
        await Preference.setString(userToken, response['jwt']);
        await Preference.setInt(userId, response['result']['user_id']);
        await Preference.setString(
            userFirstName, response['result']['full_name']);
        await Preference.setString(
            userLastName, response['result']['last_name']);
        await Preference.setString(
            matrixNumber, response['result']['matrix_number']);
        await Preference.setString(icNumber, response['result']['ic_number']);
        await Preference.setString(course, response['result']['course']);
        await Preference.setString(
            userProfilePic, response['result']['profile_picture']);
        await Preference.setString(
            userEmail, response['result']['email_address']);
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserDashboard()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: MyAppBar(appTitleText, false),
        backgroundColor: const Color(0xFFFFFFFF),
        endDrawer: const AppMenus(),
        body: Container(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 64, 20, 20),
          child: ListView(
            padding: FxSpacing.fromLTRB(16, 25, 16, 16),
            children: [
              Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: const FlareActor("assets/animations/rive/teddy.flr",
                      shouldClip: false,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain)),
              Form(
                key: _formKey,
                child: FxContainer.bordered(
                    color: theme.colorScheme.background,
                    child: Column(
                      children: [
                        FxText.headlineSmall(
                          'Hello Again!',
                          fontWeight: 700,
                          textAlign: TextAlign.center,
                        ),
                        FxSpacing.height(20),
                        TrackingTextInput(
                          style: FxTextStyle.bodyMedium(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              isDense: true,
                              fillColor: theme.cardTheme.color,
                              prefixIcon: Icon(
                                FeatherIcons.mail,
                                color: theme.colorScheme.onBackground,
                              ),
                              hintText: "Email Address",
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.bodyMedium(),
                              isCollapsed: true),
                          controller: emailController,
                          validator: (arg) {
                            var validateArray = {
                              "required": true,
                              "pattern":
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                            };
                            var validateErrorArray = {
                              "required": requiredMsg,
                              "pattern": validEmail
                            };
                            return (validateInput(
                                arg, validateArray, validateErrorArray));
                          },
                          cursorColor: theme.colorScheme.onBackground,
                        ),
                        FxSpacing.height(20),
                        TrackingTextInput(
                          isObscured: true,
                          style: FxTextStyle.bodyMedium(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              isDense: true,
                              fillColor: theme.cardTheme.color,
                              prefixIcon: Icon(
                                FeatherIcons.lock,
                                color: theme.colorScheme.onBackground,
                              ),
                              hintText: "Password",
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.bodyMedium(),
                              isCollapsed: true),
                          controller: passwordController,
                          validator: (arg) {
                            var validateArray = {
                              "required": true,
                              'minlength': 6
                            };
                            var validateErrorArray = {
                              "required": requiredMsg,
                              "minlength": passwordLength
                            };
                            return (validateInput(
                                arg, validateArray, validateErrorArray));
                          },
                          cursorColor: theme.colorScheme.onBackground,
                        ),
                        FxSpacing.height(20),
                        FxButton.block(
                          elevation: 0,
                          borderRadiusAll: 4,
                          onPressed: () {
                            final FormState? form = _formKey.currentState;
                            if (form!.validate()) {
                              userLogin(emailController.text,
                                  passwordController.text);
                            }
                          },
                          splashColor:
                              theme.colorScheme.onPrimary.withAlpha(28),
                          backgroundColor: theme.colorScheme.primary,
                          child: FxText.labelMedium(
                            "Sign In",
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    )),
              ),
              FxSpacing.height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxButton.text(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    padding: FxSpacing.zero,
                    splashColor: theme.colorScheme.primary.withAlpha(40),
                    child: FxText.bodySmall(
                      signUpLink,
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              (errorMessage != '')
                  ? error.ErrorMessageDisplay(errorMessage: errorMessage)
                  : Container()
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
