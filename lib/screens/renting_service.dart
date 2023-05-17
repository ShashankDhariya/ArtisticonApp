import 'dart:io';
import 'package:artist_icon/main.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RentingService extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const RentingService({Key? key, required this.userModel, required this.firebaseUser}): super(key: key);

  @override
  State<RentingService> createState() => _RentingServiceState();
}

class _RentingServiceState extends State<RentingService> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController paycontroller = TextEditingController();
  TextEditingController durationController = TextEditingController();
  bool st = false;
  File? img;

  void uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cropImg(pickedFile);
    }
  }

  void cropImg(XFile file) async {
    CroppedFile? croppedImg = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    if (croppedImg != null) {
      setState(() {
        img = File(croppedImg.path);
      });
    }
  }

  Future<void> check() async {
    String category = categoryController.text.trim();
    String desc = descController.text.trim();
    String address = addressController.text.trim();
    String city = citycontroller.text.trim();
    String state = stateController.text.trim();
    String country = countryController.text.trim();
    String pay = paycontroller.text.trim();

    if (category.isEmpty || desc.isEmpty || address.isEmpty || city.isEmpty || state.isEmpty || country.isEmpty || pay.isEmpty || img == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill out all the Fields")));
    } else {
      setState(() {
        st = true;
      });
      String rentid = uuid.v1();
      UploadTask uploadTask = FirebaseStorage.instance.ref('Rent_Images').child(rentid).putFile(img!);
      TaskSnapshot snapshot = await uploadTask;
      String imgUrl = await snapshot.ref.getDownloadURL();

      RentPostModel rentPost = RentPostModel(
        uid: widget.userModel.uid.toString(),
        rentid: rentid,
        provider: widget.userModel.name.toString(),
        desc: desc,
        category: category,
        phone: widget.userModel.phone,
        address: address,
        city: city,
        state: state,
        country: country,
        pay: pay,
        pic: imgUrl,
        time: DateTime.now(),
      );

      MyListingsModel listing = MyListingsModel(
        category: category,
        address: address,
        type: "Rent",
        pay: pay,
        time: DateTime.now(),
        id: rentid
      );
      FirebaseFirestore.instance.collection("Users").doc(widget.userModel.uid.toString()).collection("MyListings").doc(rentid).set(listing.toMap());
      FirebaseFirestore.instance.collection("Rents").doc(rentid).set(rentPost.toMap()).then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Posted successfully...")));
      });
    }
  }
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.32,vertical: size.height * 0.02),
                  child: Text('Service Details',
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
              controller: categoryController,
            ),
            SizedBox(height: size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
            SizedBox(height: size.height * 0.015),
            MyTextField(
              hintText: 'Address',
              obsecure: false,
              icon: Icon(Icons.map, size: MediaQuery.of(context).size.height * 0.030),
              controller: addressController,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              hintText: 'City',
              obsecure: false,
              icon: Icon(Icons.location_city, size: MediaQuery.of(context).size.height * 0.030),
              controller: citycontroller,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              hintText: 'State',
              obsecure: false,
              icon: Icon(Icons.location_on, size: MediaQuery.of(context).size.height * 0.030),
              controller: stateController,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              hintText: 'Country',
              obsecure: false,
              icon: Icon(Icons.flag, size: MediaQuery.of(context).size.height * 0.030),
              controller: countryController,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              hintText: 'Cost/time',
              obsecure: false,
              icon: Icon(Icons.currency_rupee, size: MediaQuery.of(context).size.height * 0.030),
              controller: paycontroller,
            ),
            SizedBox(height: size.height * 0.015),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: uploadPhoto,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.teal.shade300,
                ),
                child: Text('Upload Photograph',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            if (img != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.file(
                  img!,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: size.height * 0.02),
            st
            ? const CircularProgressIndicator()
            : MyButton(
                text: 'Rent Service',
                width: size.width * 0.48,
                onPressed: () {
                  check();
                },
              )
          ],
        ),
      ),
    );
  }
}