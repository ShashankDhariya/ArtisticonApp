import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentingService extends StatefulWidget {
  const RentingService({super.key});

  @override
  State<RentingService> createState() => _RentingServiceState();
}

class _RentingServiceState extends State<RentingService> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.045,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.32,
                      vertical: size.height * 0.03),
                  child: Text(
                    'Service Details',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            MyTextField(
              hintText: 'Category',
              obsecure: false,
              icon: Icon(Icons.person,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.description),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey.shade500)),
              ),
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Phone',
              obsecure: false,
              icon: Icon(CupertinoIcons.phone,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'City',
              obsecure: false,
              icon: Icon(Icons.location_city,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'State',
              obsecure: false,
              icon: Icon(Icons.location_on,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Country',
              obsecure: false,
              icon: Icon(Icons.flag,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Cost/hr',
              obsecure: false,
              icon: Icon(Icons.currency_rupee,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Duration',
              obsecure: false,
              icon: Icon(Icons.schedule_rounded,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: nameController,
            ),
            SizedBox(height: size.height * 0.025),
            MyButton(
              text: 'Rent Service',
              width: size.width * 0.48,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
