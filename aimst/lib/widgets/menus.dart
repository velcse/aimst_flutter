import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'dart:ui';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostNewAd()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Post new ad',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF3AA05),
                ),
              )),
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
                child: Column(children: const [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 36.0,
                    semanticLabel: 'Search',
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Color(0xFF02467D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ]),
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
                      Icons.contact_support_outlined,
                      color: Colors.black,
                      size: 36.0,
                      semanticLabel: 'Support',
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Support",
                        style: TextStyle(
                            color: Color(0xFF02467D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ]),
                ),
                onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SupportOptions()));
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
                child: Column(children: const [
                  Icon(
                    Icons.edit_location_alt_outlined,
                    color: Colors.black,
                    size: 36.0,
                    semanticLabel: 'Location',
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Country",
                      style: TextStyle(
                          color: Color(0xFF02467D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ]),
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
                child: Column(children: const [
                  Icon(
                    Icons.history,
                    color: Colors.black,
                    size: 36.0,
                    semanticLabel: 'history',
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "History",
                      style: TextStyle(
                          color: Color(0xFF02467D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ]),
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
                child: Column(children: const [
                  Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 36.0,
                    semanticLabel: 'Saved',
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Saved",
                      style: TextStyle(
                          color: Color(0xFF02467D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ]),
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
                child: Column(children: const [
                  Icon(
                    Icons.message,
                    color: Colors.black,
                    size: 36.0,
                    semanticLabel: 'Message',
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Message",
                      style: TextStyle(
                          color: Color(0xFF02467D),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  )
                ]),
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
                        semanticLabel: 'Accounts',
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Account",
                          style: TextStyle(
                              color: Color(0xFF02467D),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ]),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              elevation: 0.0,
                              backgroundColor: Colors.transparent,
                              child: _accountPopup(context),
                            );
                          });
                    }),
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
                child: Column(children: const [
                  Icon(
                    Icons.home,
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
            ],
          )
        ]),
      ),
    );
  }

  Widget _accountPopup(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          padding: const EdgeInsets.only(top: 0.0),
          margin: const EdgeInsets.only(top: 13.0, right: 0.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0.0),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: <BoxShadow>[
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ]),
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(top: 7, right: 18),
                        child: SizedBox(
                            height: 24,
                            width: 24,
                            child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.black, size: 24.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "Sign in or register",
                          style: TextStyle(
                              color: Color(0xFF3B4144),
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter email address',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            prefixIcon: Icon(Icons.message),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20)),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              // Respond to button press
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "I accept millioncar's Terms of Use and Privacy Policy.",
                          style:
                              TextStyle(color: Color(0xFF3B4144), fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ])))
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
