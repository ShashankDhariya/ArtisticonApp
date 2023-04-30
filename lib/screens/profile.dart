import 'package:artist_icon/screens/components/listOptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.09,
                backgroundImage: const AssetImage('assets/images/dance.jpg'),  
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text('Shashank', 
                style: GoogleFonts.montserrat(
                  
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text("Sdhariya"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              
              const Divider(),
              const SizedBox(height: 20,),
              const ListOption(icon: Icon(Icons.book), text: 'Manage Portfolio', color: Colors.black, ),
              const ListOption(icon: Icon(CupertinoIcons.pen), text: 'Edit Profile', color: Colors.black, ),
              const ListOption(icon: Icon(CupertinoIcons.settings), text: 'Setting', color: Colors.black, ),
              const ListOption(icon: Icon(Icons.info), text: 'Information', color: Colors.black, ),
              const ListOption(icon: Icon(Icons.exit_to_app), text: 'Log out', color: Colors.red, ),
            ],
          ),
        ),
      ),
    );
  }
}