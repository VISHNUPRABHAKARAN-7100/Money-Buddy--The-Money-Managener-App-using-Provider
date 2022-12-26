import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_buddy/view/home_screen/home_screen.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  static SizedBox sizedBoxHeight5 = const SizedBox(
    height: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
        title: const Text(
          'Privacy and Policy',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const HeadingClass(heading: 'Privacy Policy'),
            sizedBoxHeight5,
            const ParagraphClass(
              paragraph:
                  'VISHNU PRABHAKARAN built the Money Buddy app as a Free app.'
                  ' This SERVICE is provided by VISHNU PRABHAKARAN at no cost'
                  ' and is intended for use as is.'
                  'This page is used to inform visitors regarding my policies '
                  'with the collection, use, and disclosure of Personal'
                  ' Information if anyone decided to use my Service.'
                  'If you choose to use my Service, then you agree to the'
                  ' collection and use of information in relation to this policy.'
                  ' The Personal Information that I collect is used for providing'
                  'and improving the Service. I will not use or share your'
                  ' information with'
                  ' anyone except as described in this Privacy Policy.'
                  'The terms used in this Privacy Policy have the same meanings '
                  'as in our Terms and Conditions, which are accessible at Money'
                  ' Buddy unless otherwise defined in this Privacy Policy.',
            ),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Changes to This Privacy Policy'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'For a better experience, while using our Service,'
                    ' I may require you to provide us with certain personally '
                    'identifiable information. The information that I request '
                    'will be retained on your device and is not collected by me'
                    ' in any way.The app does use third-party services that may '
                    'collect information used to identify you.'
                    'Link to the privacy policy of third-party service'
                    ' providers used by the app'),
            sizedBoxHeight5,
            const PointFuction(word: 'Google Play Service'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Log Data'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph:
                    'I want to inform you that whenever you use my Service,'
                    ' in a case of an error in the app I collect data and'
                    ' information (through third-party products) on your phone'
                    ' called Log Data. This Log Data may include information such '
                    'as your device Internet Protocol (“IP”) address, device name,'
                    ' operating system version, the configuration of the app when'
                    ' utilizing my Service, the time and date of your use of the '
                    'Service, and other statistics.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Cookies'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'Cookies are files'
                    ' with a small amount of data that are commonly used as '
                    'anonymous unique identifiers. These are sent to your browser'
                    ' from the websites that you visit and are stored on your device\'s '
                    'internal memory.'
                    'This Service does not use these “cookies” explicitly.'
                    ' However, the app may use third-party code and libraries'
                    ' that use “cookies” to collect information and improve their'
                    ' services. You have the option to either accept or refuse these '
                    'cookies and know when a cookie is being sent to your device. If'
                    ' you choose to refuse our cookies, you may not be able to use some'
                    ' portions of this Service.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Service Provider'),
            const ParagraphClass(
                paragraph: 'I may employ third-party companies and'
                    ' individuals due to the following reasons:'),
            sizedBoxHeight5,
            const PointFuction(word: 'To facilitate our Service;'),
            const PointFuction(word: 'To provide the Service on our behalf;'),
            const PointFuction(
                word: 'To assist us in analyzing how our Service is used.'),
            const ParagraphClass(
                paragraph: 'I want to inform users of this Service that these'
                    ' third parties have access to their Personal Information.'
                    ' The reason is to perform the tasks assigned to them on our'
                    ' behalf. However, they are obligated not to disclose or use'
                    ' the information for any other purpose.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Security'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'I value your trust in providing us your'
                    ' Personal Information, thus we are striving to use commercially'
                    ' acceptable means of protecting it. But remember that no method of'
                    ' transmission over the internet, or method of electronic storage is'
                    ' 100% secure and reliable, and I cannot guarantee its absolute security.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Links to Other Sites'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph:
                    'This Service may contain links to other sites. If you click on'
                    ' a third-party link, you will be directed to that site.'
                    ' Note that these external sites are not operated by me.'
                    ' Therefore, I strongly advise you to review the Privacy Policy'
                    ' of these websites. I have no control over and assume no'
                    ' responsibility for the content, privacy policies, or practices'
                    ' of any third-party sites or services.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Children’s Privacy'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'These Services do not address anyone '
                    'under the age of 13. I do not knowingly collect personally '
                    'identifiable information from children under 13 years of age. '
                    'In the case I discover that a child under 13 has provided me with'
                    ' personal information, I immediately delete this from our servers.'
                    ' If you are a parent or guardian and you are aware that your '
                    'child has provided us with personal information, please contact'
                    ' me so that I will be able to do the necessary actions.'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Changes to This Privacy Policy'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'I may update our Privacy Policy from time to time.'
                    ' Thus, you are advised to review this page periodically for'
                    ' any changes. I will notify you of any changes by posting'
                    ' the new Privacy Policy on this page.'
                    'This policy is effective as of 2024-12-31'),
            sizedBoxHeight5,
            const HeadingClass(heading: 'Contact Us'),
            sizedBoxHeight5,
            const ParagraphClass(
                paragraph: 'If you have any questions'
                    ' or suggestions about my Privacy Policy, do not hesitate'
                    ' to contact me at vishnuprabha478@gmail.com.'
                    'This privacy policy page was created at privacypolicytemplate.'
                    'net and modified/generated by App Privacy Policy Generator'),
          ],
        ),
      ),
    );
  }
}

class HeadingClass extends StatelessWidget {
  const HeadingClass({super.key, required this.heading});
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

class ParagraphClass extends StatelessWidget {
  const ParagraphClass({super.key, required this.paragraph});
  final String paragraph;

  @override
  Widget build(BuildContext context) {
    return Text(
      paragraph,
      style: GoogleFonts.merriweather(
        fontSize: 15,
      ),
    );
  }
}

class PointFuction extends StatelessWidget {
  const PointFuction({super.key, required this.word});
  final String word;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 4,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              word,
              style: GoogleFonts.mukta(),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
