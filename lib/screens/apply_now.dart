import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ApplyNowScreen extends StatefulWidget {
  const ApplyNowScreen({Key? key}) : super(key: key);

  @override
  State<ApplyNowScreen> createState() => _ApplyNowScreenState();
}

class _ApplyNowScreenState extends State<ApplyNowScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();
  File? _portfolioFile;
  File? _photoFile;

  void _uploadPortfolio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _portfolioFile = File(result.files.single.path!);
      });
    }
  }

  void _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _photoFile = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Implement your submission logic here
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _videoLinkController.dispose();
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
          'Apply Now',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Image.asset(
                  'assets/images/artistIcon.jpeg',
                  height: 105,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                TextField(
                  maxLines: null,
                  controller: _nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Name',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  maxLines: null,
                  controller: _videoLinkController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.videocam),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Video Link (optional)',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadPortfolio,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Colors.teal.shade300,
                  ),
                  child: Text(
                    'Upload Portfolio',
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_portfolioFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _portfolioFile!.path,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadPhoto,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Colors.teal.shade300,
                  ),
                  child: Text(
                    'Upload Photograph',
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_photoFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.file(
                      _photoFile!,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submit,
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
                // MyButton(text: 'Submit', width: 40, onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
