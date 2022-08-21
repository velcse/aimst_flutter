import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/widgets/error_message_widget.dart' as error;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
import 'package:flutterapp/models/country_model.dart';
import 'package:flutterapp/localizations/en/constants.dart';
import 'package:flutterapp/utils/validators/form_validate.dart';
import 'package:flutterapp/blocs/user_bloc.dart';

String appTitleText = "";
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController matrixController = TextEditingController();
TextEditingController icNumberController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController addressOneController = TextEditingController();
TextEditingController addressTwoController = TextEditingController();
TextEditingController houseNameController = TextEditingController();
TextEditingController pinCodeController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateNameController = TextEditingController();
TextEditingController joinedYearController = TextEditingController();

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetRegisterState createState() => _GetRegisterState();
}

class _GetRegisterState extends State<Register> {
  late UserBloc _bloc;
  late ThemeData theme;
  late OutlineInputBorder outlineInputBorder;
  String errorMessage = '';
  int currentPageView = 0;
  bool profileFormValid = false;
  bool addressFormValid = false;
  bool academicFormValid = false;
  final PageController _controller =
      PageController(initialPage: 0, keepPage: false);
  String selectedCountry = '1';
  String? _genderSelected = "Gender";
  String selectedCourse = '1';
  String selectedFaculty = '1';
  String selectedRace = '1';
  String _radioHsotel = "Hostel?";
  List<dynamic> countryList = [];
  List<dynamic> raceList = [];
  List<dynamic> courseList = [];
  List<dynamic> facultyList = [];

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
    fetchCountryDetails(context);
    fetchFacultyDetails(context);
    fetchCourses(context);
    fetchRaceDetails(context);
  }

  void pageScroll(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 270), curve: Curves.linear);
    setState(() {
      currentPageView = index;
    });
  }

  Future userRegister() async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    String fullName = firstNameController.text;
    String emailAddress = emailController.text;
    String password = passwordController.text;
    String lastName = lastNameController.text;
    String matrixNumber = matrixController.text;
    String icNumber = icNumberController.text;
    String phonenumber = phoneNumberController.text;
    String addressOne = addressOneController.text;
    String addressTwo = addressTwoController.text;
    String postcode = pinCodeController.text;
    String city = cityController.text;
    String stateName = stateNameController.text;
    String joinedYear = joinedYearController.text;
    var postData = {
      'full_name': fullName,
      'email_address': emailAddress,
      'password': password,
      'last_name': lastName,
      'matrix_number': matrixNumber,
      'ic_number': icNumber,
      'gender': (_genderSelected == 'Male') ? 'M' : 'F',
      'race': selectedRace,
      'phonenumber': phonenumber,
      'address_1': addressOne,
      'address_2': addressTwo,
      'postcode': postcode,
      'city': city,
      'state': stateName,
      'country': selectedCountry,
      'course': selectedCourse,
      'faculty': selectedFaculty,
      'joined_year': joinedYear,
      'hostel': (_radioHsotel == 'Yes' ? "1" : "0"),
      'reqtype': 'app'
    };
    try {
      final response = await _bloc.registerUser(postData);
      if (response['status'] == true) {
        EasyLoading.showSuccess('Register Sucesss');
        setState(() {
          errorMessage = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(appTitleText, true),
        backgroundColor: const Color(0xFFFFFFFF),
        endDrawer: const AppMenus(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Row(
                children: <Widget>[
                  (profileFormValid == true)
                      ? Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(color: Colors.green),
                              borderRadiusAll: 4,
                              color: Colors.white70,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  const Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.green,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Profile",
                                          color: Colors.green,
                                          fontWeight: 700)),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ],
                              ),
                              onTap: () {
                                pageScroll(0);
                              }),
                        )
                      : Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(
                                  color: (currentPageView == 0)
                                      ? theme.colorScheme.primary
                                      : Colors.white),
                              borderRadiusAll: 4,
                              color: (currentPageView == 0)
                                  ? Colors.white70
                                  : const Color(0xFFEBF1F1),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_circle_rounded,
                                    color: (currentPageView == 0)
                                        ? theme.colorScheme.primary
                                        : Colors.black38,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Profile",
                                          color: (currentPageView == 0)
                                              ? theme.colorScheme.primary
                                              : Colors.black38,
                                          fontWeight: 700))
                                ],
                              ),
                              onTap: () {
                                pageScroll(0);
                              }),
                        ),
                  (addressFormValid == true)
                      ? Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(color: Colors.green),
                              borderRadiusAll: 4,
                              color: Colors.white70,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  const Icon(
                                    MdiIcons.mapMarkerOutline,
                                    color: Colors.green,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Address",
                                          color: Colors.green,
                                          fontWeight: 700)),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ],
                              ),
                              onTap: () {
                                pageScroll(1);
                              }),
                        )
                      : Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(
                                  color: (currentPageView == 1)
                                      ? theme.colorScheme.primary
                                      : Colors.white),
                              borderRadiusAll: 4,
                              color: (currentPageView == 1)
                                  ? Colors.white70
                                  : const Color(0xFFEBF1F1),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.mapMarkerOutline,
                                    color: (currentPageView == 1)
                                        ? theme.colorScheme.primary
                                        : Colors.black38,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Address",
                                          color: (currentPageView == 1)
                                              ? theme.colorScheme.primary
                                              : Colors.black38,
                                          fontWeight: 700))
                                ],
                              ),
                              onTap: () {
                                pageScroll(1);
                              }),
                        ),
                  (academicFormValid == true)
                      ? Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(color: Colors.green),
                              borderRadiusAll: 4,
                              color: Colors.white70,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  const Icon(
                                    Icons.cast_for_education,
                                    color: Colors.green,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Academic",
                                          color: Colors.green,
                                          fontWeight: 700)),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ],
                              ),
                              onTap: () {
                                pageScroll(2);
                              }),
                        )
                      : Expanded(
                          child: FxContainer.bordered(
                              border: Border.all(
                                  color: (currentPageView == 2)
                                      ? theme.colorScheme.primary
                                      : Colors.white),
                              borderRadiusAll: 4,
                              color: (currentPageView == 2)
                                  ? Colors.white70
                                  : const Color(0xFFEBF1F1),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(left: 4, right: 4),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.cast_for_education,
                                    color: (currentPageView == 2)
                                        ? theme.colorScheme.primary
                                        : Colors.black38,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: FxText.bodyMedium("Academic",
                                          color: (currentPageView == 2)
                                              ? theme.colorScheme.primary
                                              : Colors.black38,
                                          fontWeight: 700))
                                ],
                              ),
                              onTap: () {
                                pageScroll(2);
                              }),
                        ),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Expanded(
                    child: PageView(controller: _controller, children: <Widget>[
                  Container(
                    height: double.maxFinite,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: _profileForm(context),
                  ),
                  Container(
                    height: double.maxFinite,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: _addressForm(context),
                  ),
                  Container(
                    height: double.maxFinite,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: _academicForm(context),
                  )
                ]))),
            (errorMessage != '')
                ? error.ErrorMessageDisplay(errorMessage: errorMessage)
                : Container()
          ],
        ));
  }

  Widget _profileForm(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: firstNameController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "First Name",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          keyboardType: TextInputType.text,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: lastNameController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Last Name",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onBackground,
          keyboardType: TextInputType.text,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: matrixController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.onetwothree,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Matrix number",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          keyboardType: TextInputType.number,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: icNumberController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.onetwothree,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "IC Number(12 Digit)",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onBackground,
          keyboardType: TextInputType.number,
          validator: (arg) {
            var validateArray = {"required": true, 'length': 12};
            var validateErrorArray = {
              "required": requiredMsg,
              "length": "12 digits required"
            };
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: emailController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                FeatherIcons.mail,
                color: theme.colorScheme.onBackground,
              ),
              hintText: emialHint,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          keyboardType: TextInputType.emailAddress,
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
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: phoneNumberController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.phone,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Phone number",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          keyboardType: TextInputType.number,
          validator: (arg) {
            var validateArray = {
              "required": true,
              "pattern": r'^\d+$',
              "minlength": 5
            };
            var validateErrorArray = {
              "required": requiredMsg,
              "pattern": "enter valid phone number",
              "minlength": "minimum 5 digits required"
            };
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: passwordController,
          style: FxTextStyle.bodyMedium(),
          obscureText: true,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                FeatherIcons.lock,
                color: theme.colorScheme.onBackground,
              ),
              hintText: passwordHint,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onBackground,
          validator: (arg) {
            var validateArray = {"required": true, 'minlength': 6};
            var validateErrorArray = {
              "required": requiredMsg,
              "minlength": passwordLength
            };
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
              label: const Text("Gender"),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.supervised_user_circle_rounded,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Gender",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          value: _genderSelected,
          items: <String>['Gender', 'Male', 'Female'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _genderSelected = value!);
          },
        ),
        Container(
          margin: FxSpacing.top(16),
          alignment: Alignment.center,
          child: FxButton(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                final FormState? form = _formKey.currentState;
                var profileFormValided = validateProfileForm() as bool;
                if (form!.validate()) {
                  // ignore: unrelated_type_equality_checks
                  if (profileFormValided == true) {
                    pageScroll(1);
                  }
                } else {
                  // ignore: unrelated_type_equality_checks
                  if (profileFormValided == true) {
                    pageScroll(1);
                  }
                }
              },
              padding: FxSpacing.xy(24, 8),
              child: FxText.bodyMedium("NEXT",
                  fontWeight: 600,
                  letterSpacing: 0.2,
                  color: theme.colorScheme.onPrimary)),
        ),
      ],
    ));
  }

  Widget _addressForm(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: addressOneController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Address 1",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: addressTwoController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Address 2",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onBackground,
          keyboardType: TextInputType.text,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: houseNameController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.home_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "House",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: pinCodeController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.format_list_numbered_rtl_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Pin Code",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onBackground,
          keyboardType: TextInputType.number,
          validator: (arg) {
            var validateArray = {"required": true, 'length': 12};
            var validateErrorArray = {
              "required": requiredMsg,
              "length": "12 digits required"
            };
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: cityController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.location_city_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "City",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        TextFormField(
          controller: stateNameController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.location_city,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "State",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          validator: (arg) {
            var validateArray = {"required": true};
            var validateErrorArray = {"required": requiredMsg};
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        (countryList.isNotEmpty)
            ? DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    labelStyle: FxTextStyle.bodyMedium(),
                    fillColor: theme.colorScheme.primaryContainer,
                    prefixIcon: Icon(
                      Icons.map_rounded,
                      color: theme.colorScheme.onBackground,
                    ),
                    hintText: "Country",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                value: selectedCountry,
                items: countryList.map((dynamic map) {
                  return DropdownMenuItem<String>(
                    value: map['id'],
                    child: Text(map['country_name'],
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedCountry = value!);
                },
              )
            : const Text("Getting data"),
        FxSpacing.height(22),
        Container(
          margin: FxSpacing.top(16),
          alignment: Alignment.center,
          child: FxButton(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                final FormState? form = _formKey.currentState;
                var addressFormValided = validateAddressForm() as bool;
                if (form!.validate()) {
                  // ignore: unrelated_type_equality_checks
                  if (addressFormValided == true) {
                    pageScroll(2);
                  }
                } else {
                  // ignore: unrelated_type_equality_checks
                  if (addressFormValided == true) {
                    pageScroll(2);
                  }
                }
              },
              padding: FxSpacing.xy(24, 8),
              child: FxText.bodyMedium("NEXT",
                  fontWeight: 600,
                  letterSpacing: 0.2,
                  color: theme.colorScheme.onPrimary)),
        ),
      ],
    ));
  }

  Widget _academicForm(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        (courseList.isNotEmpty)
            ? DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                    labelText: 'Course',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    labelStyle: FxTextStyle.bodyMedium(),
                    fillColor: theme.colorScheme.primaryContainer,
                    prefixIcon: Icon(
                      Icons.category,
                      color: theme.colorScheme.onBackground,
                    ),
                    hintText: "Course",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                value: selectedCourse,
                items: courseList.map((dynamic map) {
                  return DropdownMenuItem<String>(
                    value: map['id'],
                    child: Text(map['name'],
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedCourse = value!);
                },
              )
            : const Text("Getting data"),
        FxSpacing.height(22),
        (facultyList.isNotEmpty)
            ? DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                    labelText: 'Faculty',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    labelStyle: FxTextStyle.bodyMedium(),
                    fillColor: theme.colorScheme.primaryContainer,
                    prefixIcon: Icon(
                      Icons.category_sharp,
                      color: theme.colorScheme.onBackground,
                    ),
                    hintText: "Faculty",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: false),
                value: selectedFaculty,
                items: facultyList.map((dynamic map) {
                  return DropdownMenuItem<String>(
                    value: map['id'],
                    child: Text(map['name'],
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedFaculty = value!);
                },
              )
            : const Text("Getting data"),
        FxSpacing.height(22),
        (raceList.isNotEmpty)
            ? DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                    labelText: 'Race',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    labelStyle: FxTextStyle.bodyMedium(),
                    fillColor: theme.colorScheme.primaryContainer,
                    prefixIcon: Icon(
                      Icons.category_outlined,
                      color: theme.colorScheme.onBackground,
                    ),
                    hintText: "Race",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                value: selectedRace,
                items: raceList.map((dynamic map) {
                  return DropdownMenuItem<String>(
                    value: map['id'],
                    child: Text(map['name'],
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedCourse = value!);
                },
              )
            : const Text("Getting data"),
        FxSpacing.height(22),
        TextFormField(
          controller: joinedYearController,
          style: FxTextStyle.bodyMedium(),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.calendar_today_outlined,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Joined Year",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          maxLines: 1,
          cursorColor: theme.colorScheme.onPrimaryContainer,
          keyboardType: TextInputType.number,
          validator: (arg) {
            var validateArray = {
              "required": true,
              "pattern": r'^\d+$',
            };
            var validateErrorArray = {
              "required": "Required",
              "pattern": "Enter valid year",
            };
            return (validateInput(arg, validateArray, validateErrorArray));
          },
        ),
        FxSpacing.height(22),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
              label: const Text("Hostel"),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              isDense: true,
              labelStyle: FxTextStyle.bodyMedium(),
              fillColor: theme.colorScheme.primaryContainer,
              prefixIcon: Icon(
                Icons.home_filled,
                color: theme.colorScheme.onBackground,
              ),
              hintText: "Hostel",
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              border: outlineInputBorder,
              contentPadding: FxSpacing.all(16),
              hintStyle: FxTextStyle.bodyMedium(),
              isCollapsed: true),
          value: _radioHsotel,
          items: <String>['Hostel?', 'Yes', 'No'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _radioHsotel = value!);
          },
        ),
        FxSpacing.height(22),
        Container(
          margin: FxSpacing.top(16),
          alignment: Alignment.center,
          child: FxButton(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                final FormState? form = _formKey.currentState;
                var profileFormValided = validateProfileForm() as bool;
                var addressFormValided = validateAddressForm() as bool;
                if (form!.validate()) {
                  // ignore: unrelated_type_equality_checks
                  // ignore: unrelated_type_equality_checks
                  if (profileFormValided == false) {
                    pageScroll(0);
                  } else if (addressFormValided == false) {
                    pageScroll(1);
                  } else {
                    setState(() {
                      academicFormValid = true;
                    });
                    userRegister();
                  }
                } else {
                  // ignore: unrelated_type_equality_checks
                  if (profileFormValided == false) {
                    pageScroll(0);
                  } else if (addressFormValided == false) {
                    pageScroll(1);
                  }
                }
              },
              padding: FxSpacing.xy(24, 8),
              child: FxText.bodyMedium("SAVE",
                  fontWeight: 600,
                  letterSpacing: 0.2,
                  color: theme.colorScheme.onPrimary)),
        ),
      ],
    ));
  }

  Future fetchCountryDetails(BuildContext context) async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.getCountries();
      if (response['status'] == true) {
        setState(() {
          countryList = response['result'];
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      errorMessage = apiError;
      EasyLoading.dismiss();
    }
  }

  Future fetchFacultyDetails(BuildContext context) async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.getFacultyDetails();
      if (response['status'] == true) {
        setState(() {
          facultyList = response['result'];
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      errorMessage = apiError;
      EasyLoading.dismiss();
    }
  }

  Future fetchCourses(BuildContext context) async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.getCourses();
      if (response['status'] == true) {
        setState(() {
          courseList = response['result'];
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      errorMessage = apiError;
      EasyLoading.dismiss();
    }
  }

  Future fetchRaceDetails(BuildContext context) async {
    EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));
    try {
      final response = await _bloc.getRaceDetails();
      if (response['status'] == true) {
        setState(() {
          raceList = response['result'];
        });
      }
      EasyLoading.dismiss();
    } catch (e) {
      errorMessage = apiError;
      EasyLoading.dismiss();
    }
  }

  validateProfileForm() {
    bool returnValue = true;
    String fullName = firstNameController.text;
    String emailAddress = emailController.text;
    String password = passwordController.text;
    String lastName = lastNameController.text;
    String matrixNumber = matrixController.text;
    String icNumber = icNumberController.text;
    String phonenumber = phoneNumberController.text;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (fullName.isEmpty ||
        lastName.isEmpty ||
        emailAddress.isEmpty ||
        password.length < 6 ||
        matrixNumber.isEmpty ||
        icNumber.length != 12 ||
        phonenumber.length < 5) {
      returnValue = false;
    } else if (!regex.hasMatch(emailAddress)) {
      returnValue = false;
    } else if (_genderSelected == 'Gender') {
      returnValue = false;
      setState(() {
        errorMessage = 'Please select gender';
      });
    } else {
      setState(() {
        errorMessage = '';
        profileFormValid = true;
      });
    }
    return returnValue;
  }

  validateAddressForm() {
    bool returnValue = true;
    String addressOne = addressOneController.text;
    String addressTwo = addressTwoController.text;
    String houseName = houseNameController.text;
    String postcode = pinCodeController.text;
    String city = cityController.text;
    String stateName = stateNameController.text;

    if (addressOne.isEmpty ||
        addressTwo.isEmpty ||
        postcode.isEmpty ||
        city.isEmpty ||
        stateName.isEmpty ||
        houseName.isEmpty) {
      returnValue = false;
    } else {
      setState(() {
        errorMessage = '';
        addressFormValid = true;
      });
    }
    return returnValue;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
