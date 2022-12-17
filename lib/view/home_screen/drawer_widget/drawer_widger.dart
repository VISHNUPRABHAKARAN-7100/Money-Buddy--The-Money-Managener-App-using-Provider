// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_buddy/view/home_screen/drawer_widget/privacy_policy/privacy_policy.dart';
import '../../../db/category/category_db.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../about_us/about_us.dart';
import '../../splash_screen/splash_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets\\drawer.jpg'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.sanchez(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const AboutUs();
                            },
                          ));
                        },
                        title: Text(
                          'About Us',
                          style: GoogleFonts.sanchez(
                              fontSize: 20,
                              color: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.w600),
                        ),
                        leading: const Icon(FontAwesomeIcons.info),
                      ),
                      ListTile(
                        title: Text(
                          'Privacy & Policy',
                          style: GoogleFonts.sanchez(
                              fontSize: 20,
                              color: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.w600),
                        ),
                        leading: const Icon(Icons.privacy_tip),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const PrivaacyPolicy();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(FontAwesomeIcons.arrowsRotate, size: 26),
                        title: Text(
                          'Reset All',
                          style: GoogleFonts.sanchez(
                              fontSize: 20,
                              color: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: const Text(
                                  'Are you sure?',
                                  style: TextStyle(fontSize: 19),
                                ),
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          CategoryDB.instance.resetAll();
                                          TransactionDB.instance
                                              .resetTransactions();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const SplashScreen();
                                            },
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ]),
                    Column(children: [
                      Divider(
                        thickness: 2,
                        color: Colors.blue.shade100,
                        endIndent: 3,
                        height: 20,
                        indent: 3,
                      ),
                      Center(
                        child: Text(
                          'Money Buddy',
                          style: GoogleFonts.sanchez(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue.shade500,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Version  1.0.2',
                          style: GoogleFonts.sanchez(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.blue.shade100,
                        endIndent: 3,
                        height: 20,
                        indent: 3,
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
