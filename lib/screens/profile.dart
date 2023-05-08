import 'package:artist_icon/screens/components/list_options.dart';
import 'package:artist_icon/screens/profileOptions/edit.dart';
import 'package:artist_icon/screens/profileOptions/my_applications.dart';
import 'package:artist_icon/screens/profileOptions/my_listings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(icon: const Icon(CupertinoIcons.left_chevron), 
          onPressed: () {
            Navigator.pop(context);
          },),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text('Profile', 
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: Colors.black,
            )
          )
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () {  },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.09,
                  backgroundImage: const AssetImage('assets/images/dance.jpg'),  
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.010),
              Text('Shashank', 
                style: GoogleFonts.montserrat(
                  
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              const Text("Sdhariya"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
              ListOption(icon: const Icon(Icons.book), text: 'My Applications', color: Colors.black, 
              ontap: () { Navigator.push(context, MaterialPageRoute(builder:(context) {return const MyApplications();},)); }, ),
              ListOption(icon: const Icon(CupertinoIcons.book_circle), text: 'My Listings', color: Colors.black, 
              ontap: () { Navigator.push(context, MaterialPageRoute(builder:(context) {return const MyListings();},)); }, ),
              ListOption(icon: const Icon(CupertinoIcons.pen), text: 'Edit Profile', color: Colors.black, 
              ontap: () { Navigator.push(context, MaterialPageRoute(builder:(context) {return const EditProfile();},)); }, ),
              ListOption(icon: const Icon(Icons.info), text: 'Information', color: Colors.black, ontap: () {  }, ),
              ListOption(icon: const Icon(Icons.exit_to_app), text: 'Log out', color: Colors.red, ontap: () {  }, ),
            ],
          ),
        ),
      ),
    );
  }
}