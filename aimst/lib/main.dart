import 'package:flutter/material.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/view/onboard/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/view/dashboard/dashboard.dart';
import 'package:flutterapp/widgets/loading_widget.dart' as _loader;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIMST STUDENT ENTRY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AIMST STUDENT ENTRY'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _checkUserLoggedInStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            // ignore: prefer_const_constructors
            child: Column(children: const [
              Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/aimst_logo.png'),
              ),
              _loader.Loading(loadingMessage: ""),
            ])),
      ),
    );
  }
}

void _checkUserLoggedInStatus(context) async {
  await Preference.init();
  await Preference.setString(contactEmail, "contact@aimstuniversity.com");
  await Preference.setString(siteName, "aimstuniversity.com");
  await Preference.setString(appTitle, "AIMST\nUNIVERSITY");
  await Preference.setString(currencySymbol, "Rm");
  Future.delayed(const Duration(milliseconds: 1500), () {
    // ignore: unnecessary_null_comparison
    if (Preference.getString(userToken) != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserDashboard()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    }
  });
}
