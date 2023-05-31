import 'package:artist_icon/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showDeleteConfirmationDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Confirm Account Deletion'),
            content:
                const Text('\nAre you sure you want to delete your account?\n\nAfter account deletion you no longer will be able to use this account.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {                
                  try {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.delete();
                      FirebaseFirestore.instance.collection('Users').doc(user.uid.toString()).delete();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account deleted successfully')));
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Splash()),
                      ); 
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User is already logged out or does not exist')));
                    }
                  } 
                  catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Error occurred while deleting the account')));
                  }               
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.4,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '''This Privacy Policy describes how ArtistIcon collects, uses, and discloses personal information when users interact with our app. By using the ArtistIcon app, you consent to the practices described in this policy.

Information We Collect
1.1 Personal Information:
We may collect the following personal information from users:
i) Name
ii) Email address
iii) Phone number

1.2 Additional Information:
In addition to personal information, we may collect other relevant information provided by users, such as:

i) Profile information (e.g., bio, profile picture)
ii) Job details (e.g., job descriptions, location, budget)
iii) Service details (e.g., service descriptions, availability, pricing)
iv) Use of Information

2.1 Personal Information:
We use personal information for the following purposes:

i) To create and manage user accounts
ii) To facilitate communication between users
iii) To provide customer support
iv) To send important notifications and updates
v) To personalize user experiences
vi) To improve our services and develop new features

2.2 Job and Service Information:
Information related to jobs and services posted by users, such as descriptions and availability, may be publicly visible within the app.

Disclosure of Information

3.1 Service Providers:
We may share personal information with trusted service providers who assist us in delivering and improving our services. These service providers are obligated to protect the confidentiality and security of the information.

3.2 Legal Requirements:
We may disclose personal information if required to do so by law or in response to valid requests by public authorities.

Data Security
We implement industry-standard security measures to protect personal information from unauthorized access, loss, or misuse. However, please note that no method of data transmission over the internet or electronic storage is completely secure.


Children's Privacy
The ArtistIcon app is not intended for children under the age of 13. We do not knowingly collect personal information from children. If we become aware that we have inadvertently collected personal information from a child under 13, we will promptly delete it.

User Rights
Users have certain rights regarding their personal information, including the right to access, modify, or delete their information. Users can exercise these rights by contacting us through the information provided in the "Contact Us" section below.

Changes to this Privacy Policy
We may update this Privacy Policy from time to time. Users will be notified of any significant changes via email or by a notice within the app. We encourage users to review the Privacy Policy periodically.

Contact Us
If you have any questions, concerns, or requests regarding this Privacy Policy or the handling of your personal information, please contact us at [artisticon7@gmail.com].
 ''',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            GestureDetector(
              onTap: showDeleteConfirmationDialog, 
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.delete, 
                      color: Colors.red,
                    ),
                    const SizedBox(height: 5),
                    Text('Delete Account', 
                      style: GoogleFonts.nunito(
                        color: Colors.red,
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}