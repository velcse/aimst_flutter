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
import 'package:flutterapp/view/profile/userprofiledetailspage.dart';
import 'package:flutterapp/view/login/login_form.dart';

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
      backgroundColor: theme.colorScheme.primary,
      leading: Row(children: <Widget>[
        (showBackArrow == true)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop())
            : const Text(""),
      ]),
      title: (Preference.getString(userFirstName)) != null
          ? _titleWidget()
          : _titleWidget(),
      actions: [
        (Preference.getString(userToken) != null)
            ? GestureDetector(
                child: const Icon(Icons.menu),
                onTap: () => Scaffold.of(context).openEndDrawer(),
              )
            : const Text(""),
      ],
    );
  }

  Widget _titleWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(right: 15),
          child: const Icon(
            Icons.star_border_outlined,
            color: Colors.white,
            size: 40,
          )),
      Text(
        title,
        style: const TextStyle(color: Colors.white),
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
    var _opacity = 0.7;
    var _xOffset = 0.0;
    var _yOffset = 3.0;
    var _blurRadius = 7.0;
    var _spreadRadius = 5.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.red,
      child: AdvancedDrawer(
        backdropColor: const Color(0xFF19ADD1),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        drawer: SafeArea(
          child: Container(),
        ),
        child: ListView(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 36.0,
                  semanticLabel: 'Back Arrow',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withOpacity(_opacity),
                  offset: Offset(_xOffset, _yOffset),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius,
                )
              ],
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child: Image.asset(
                    "./assets/images/profile/avatar_place.png",
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FxText.titleLarge(
                          Preference.getString(userFirstName).toString(),
                          fontWeight: 600,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          letterSpacing: 0),
                      FxText.bodyLarge(
                          Preference.getString(userEmail).toString(),
                          fontWeight: 400,
                          letterSpacing: 0.2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(15),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            physics:
                const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFFFFF).withOpacity(_opacity),
                        offset: Offset(_xOffset, _yOffset),
                        blurRadius: _blurRadius,
                        spreadRadius: _spreadRadius,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(children: const [
                    Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 36.0,
                      semanticLabel: 'Home',
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Color(0xFF02467D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserDashboard()));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFFFFF).withOpacity(_opacity),
                        offset: Offset(_xOffset, _yOffset),
                        blurRadius: _blurRadius,
                        spreadRadius: _spreadRadius,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(children: const [
                    Icon(
                      Icons.local_activity,
                      color: Colors.black,
                      size: 36.0,
                      semanticLabel: 'Laundry',
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Laundry",
                        style: TextStyle(
                            color: Color(0xFF02467D),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoundryEntryDashboard()));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFFFFF).withOpacity(_opacity),
                        offset: Offset(_xOffset, _yOffset),
                        blurRadius: _blurRadius,
                        spreadRadius: _spreadRadius,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(children: const [
                    Icon(
                      Icons.food_bank,
                      color: Colors.black,
                      size: 36.0,
                      semanticLabel: 'Cafetaria',
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Cafea",
                        style: TextStyle(
                            color: Color(0xFF02467D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EntryDashboard()));
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFFFFF).withOpacity(_opacity),
                      offset: Offset(_xOffset, _yOffset),
                      blurRadius: _blurRadius,
                      spreadRadius: _spreadRadius,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                    child: Column(children: const [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 36.0,
                        semanticLabel: 'Profile',
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Color(0xFF02467D),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ]),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserProfile()));
                    }),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  _logoutUser(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF3AA05),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
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
