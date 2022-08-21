import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> getJson() {
  return rootBundle.loadString('language/en.json');
}

Future<dynamic> getLanguageDta(textKey) async {
  var myData = json.decode(await getJson());
  myData.onBoardingTitle;
  return myData;
}
