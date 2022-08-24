import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int currentIOSAppVersion = 1;

typedef StringCallback = void Function(String);

// ignore: constant_identifier_names
const String PREF_COUNTRY = "country_code";
const String userToken = "token";
const String roleId = "role_id";
const String userId = "user_id";
const String userFirstName = "first_name";
const String userLastName = "last_name";
const String userEmail = "email";
const String userMobile = "mobile_number";
const String userWallet = "amount";
const String userRoleNumber = "role_number";
const String matrixNumber = "matrix_number";
const String icNumber = "ic_number";
const String course = "course";
const String userProfilePic = "user_profile_pic";
const String contactEmail = "contact_email";
const String siteName = "site_name";
const String appTitle = "app_title";
const String currencySymbol = "currency_sumbol";

//Social Media Keys
// ignore: constant_identifier_names
const String ANDROID_API_KEY = "AIzaSyBHN1a0K6FmTbGO9XHRP4U57vY4pW1pSxs";

String getAppId() {
  return Platform.isAndroid ? 'AndroidApp' : 'IphoneApp';
}

const Color buttonRedColor = Color.fromRGBO(209, 15, 51, 1.0);
const Color warrantyPriceTextColor = Color.fromRGBO(28, 36, 48, 1.0);
const Color applyButtonColor = Color.fromRGBO(224, 235, 242, 1.0);
const Color buttonSeperatorGreenColor = Color.fromRGBO(74, 179, 92, 1.0);
const Color termsAndConditionColor = Color.fromRGBO(0, 102, 170, 1.0);
const Color couponCodeTextColor = Color.fromRGBO(56, 61, 77, 1.0);
const Color errorCouponCodeBackGroundColor = Color.fromRGBO(245, 237, 238, 1.0);
const Color seecBackgroundColor = Color.fromRGBO(237, 244, 235, 1);
const Color yellowLightBackgroundColor = Color.fromRGBO(255, 232, 0, 0.12);
const Color yellowLightBorderColor = Color.fromRGBO(214, 196, 15, 0.40);
const Color searchTextResultColor = Color.fromRGBO(28, 36, 48, 1);
const Color addressPlaceholderColor = Color.fromRGBO(94, 99, 112, 1);
const Color addToCartButtonColor = Color.fromRGBO(0, 102, 166, 1);
const Color slotsNABackGroundColor = Color.fromRGBO(214, 217, 219, 0.40);
const Color slotSelectedBorderColor = Color.fromRGBO(0, 102, 166, 1);
const Color slotSelectedBackGroundColor = Color.fromRGBO(0, 102, 166, 0.05);
const Color yellowButtonColor = Color(0xffffe700);
const Color textLinkColor = Color.fromRGBO(50, 113, 184, 1.0);
const Color checkoutYellowBackGroundColor = Color.fromRGBO(252, 251, 243, 1);
const Color mapErrorRedBorderColor = Color.fromRGBO(235, 94, 0, 1);
const Color mapErrorRedBackGroundColor = Color.fromRGBO(254, 243, 245, 1);
const Color mapErrorTextColor = Color.fromRGBO(229, 0, 46, 1);

setBoxBorders(Color borderColor, Color backgroudColor) => BoxDecoration(
      color: backgroudColor,
      border: Border(
          right: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          left: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          top: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: 1.0,
          )),
    );
