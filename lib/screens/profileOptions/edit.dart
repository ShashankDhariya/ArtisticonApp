import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool state = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF43B1B7),
          foregroundColor: Colors.black,
          elevation: 0.4,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.left_chevron),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {},
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFF5CEB8),
                  foregroundColor: Colors.white,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              MyTextField(
                hintText: 'Username',
                obsecure: false,
                icon: Icon(Icons.person,
                    size: MediaQuery.of(context).size.height * 0.027),
                controller: nameController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              MyTextField(
                hintText: 'Name',
                obsecure: true,
                icon: Icon(Icons.person_2,
                    size: MediaQuery.of(context).size.height * 0.027),
                controller: nameController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              MyTextField(
                hintText: 'Phone Number',
                obsecure: true,
                icon: Icon(Icons.call,
                    size: MediaQuery.of(context).size.height * 0.027),
                controller: phoneController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              state
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 160.0, // Set the desired width of the button
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: const Color(0xFF43B1B7),
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
