import 'package:flutter/material.dart';
import 'package:flutterapp/theme/app_theme.dart';
import 'package:flutterapp/utils/spacing.dart';
import 'package:flutterapp/widgets/text/text.dart';
import 'package:flutterapp/widgets/container/container.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/models/activitylogs_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String appTitleText = "";
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class EntryDashboard extends StatefulWidget {
  const EntryDashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetEntryDashboardState createState() => _GetEntryDashboardState();
}

class _GetEntryDashboardState extends State<EntryDashboard> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: FxSpacing.fromLTRB(24, 18, 24, 24), children: [
      FxText.titleMedium(
        'Activity Logs (Cafetaria)',
        letterSpacing: 0.5,
        fontWeight: 700,
      ),
      FxSpacing.height(16),
      SingleChildScrollView(
          child: Column(children: [
        FutureBuilder<ActivityLogModel>(
            future: _getCaferariaLogs(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.result.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: 0,
                              color: Colors.white,
                            ),
                        itemBuilder: (context, index) {
                          return FxContainer(
                            border: Border.all(color: Colors.white),
                            color: Colors.white70,
                            margin: const EdgeInsets.only(bottom: 5),
                            paddingAll: 8,
                            child: Column(children: [
                              Row(
                                children: [
                                  FxContainer(
                                    width: 76,
                                    padding: FxSpacing.y(12),
                                    borderRadiusAll: 0,
                                    bordered: false,
                                    border: Border.all(color: Colors.white),
                                    color: Colors.white,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          FxContainer(
                                            height: 50,
                                            width: 50,
                                            paddingAll: 0,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/apps/food/pasta-1.jpg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FxSpacing.width(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FxText.bodySmall(
                                          snapshot.data!.result[index].slot,
                                          fontWeight: 600,
                                          fontSize: 15,
                                        ),
                                        FxSpacing.height(4),
                                        FxText.bodySmall(
                                          snapshot.data!.result[index].created,
                                          fontSize: 15,
                                        ),
                                        FxSpacing.height(4),
                                        FxText.bodySmall(
                                          "Verified By : ${snapshot.data!.result[index].verifedBy}",
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(16),
                                ],
                              ),
                              FxSpacing.height(10),
                              const Divider(
                                thickness: 0.3,
                                color: Colors.grey,
                              ),
                            ]),
                          );
                        }));
              } else {
                return const Text("Getting logs....");
              }
            })
      ]))
    ]));
  }

  Future<ActivityLogModel> _getCaferariaLogs(BuildContext context) async {
    ActivityLogModel returnData;
    await Preference.init();
    EasyLoading.show(
        indicator: CircularProgressIndicator(color: Colors.lightBlue[900]));

    var postData = {
      'jwt': Preference.getString(userToken),
      'entry_gate_id': 1,
      'reqtype': 'app'
    };
    String body = json.encode(postData);

    final http.Response response = await http.post(
      Uri.parse(
          'https://projects.kensist.com/college_entry/api/getActivityLog'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    Map<String, dynamic> decodeJson =
        jsonDecode(utf8.decode(response.bodyBytes));

    EasyLoading.dismiss();
    return ActivityLogModel.fromJson(decodeJson);
  }
}
