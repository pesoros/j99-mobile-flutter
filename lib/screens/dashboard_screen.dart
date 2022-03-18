// ignore_for_file: unused_import
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:juragan99/screens/dashboard/search_ticket_screen.dart';
import 'package:juragan99/screens/dashboard/search_package_screen.dart';
import 'package:juragan99/screens/dashboard/pariwisata_screen.dart';
import 'dashboard/home_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_custom_tab_bar/models.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:flutter_custom_tab_bar/transform/tab_bar_transform.dart';

import 'package:juragan99/screens/settings/my_profile_screen.dart';
import 'package:juragan99/utils/variables.dart' as variable;

class DashboardScreen extends StatefulWidget {
  final int selectedPage;
  DashboardScreen(this.selectedPage);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    (token == null)
        ? Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignInScreen()))
        : Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.selectedPage,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: CustomColor.darkGrey,
            title: Image.asset(
              'assets/images/j99-logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: CustomColor.white,
                    ),
                    onPressed: () {
                      getUser();
                    }),
              ),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: CustomColor.white,
                    ),
                    height: 30,
                    width: MediaQuery.of(context).size.width / 1.1,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(1),
                    child: TabBar(
                        padding: EdgeInsets.all(0),
                        unselectedLabelColor: CustomColor.darkGrey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: CustomColor.darkGrey),
                        tabs: [
                          Tab(
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Beli Tiket",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Cari Tiket",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Pariwisata",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Cari Paket",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                )),
          ),
          body: TabBarView(children: [
            HomeScreen(),
            SearchTicketScreen(),
            PariwisataScreen(),
            SearchPackageScreen(),
          ]),
        ));
  }
}
