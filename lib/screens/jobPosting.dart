import 'package:artist_icon/screens/components/myButton.dart';
import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPosting extends StatelessWidget {
  const JobPosting({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.045,
                        color: const Color(0xFFF5CEB8),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.32, vertical: size.height * 0.03),
                        child: Text('Job Details', 
                          style: GoogleFonts.montserrat (
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyTextField(hintText: 'Category', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.018),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03,) ,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(Icons.description),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey.shade500)
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.018),
                  MyTextField(hintText: 'Phone', obsecure: false, icon: Icon(CupertinoIcons.phone ,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.018),
                  MyTextField(hintText: 'City', obsecure: false, icon: Icon(Icons.location_city,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.018),
                  MyTextField(hintText: 'State', obsecure: false, icon: Icon(Icons.location_on,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.018),
                  MyTextField(hintText: 'Expected Salary', obsecure: false, icon: Icon(CupertinoIcons.money_dollar ,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.018),
                  MyTextField(hintText: 'Anything Else', obsecure: false, icon: Icon(CupertinoIcons.option ,size: MediaQuery.of(context).size.height * 0.030),),
                  SizedBox(height: size.height * 0.025),
                  MyButton(
                    onTap:() {
                      
                    }, 
                    text: 'Post Job', width: size.width * 0.88)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}