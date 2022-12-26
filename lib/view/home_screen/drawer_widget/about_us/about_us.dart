import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
        title: const Text('About Us'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(FontAwesomeIcons.arrowLeftLong),
        ),
      ),
      body: Center(
        child: RichText(
          text: const TextSpan(
            text: 'This App is developed by\n',
            style: TextStyle(color: Colors.black, fontSize: 25),
            children: [
              TextSpan(
                text: 'VISHNU PRABHAKARAN',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
