import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ApplyNowScreen extends StatefulWidget {
  const ApplyNowScreen({super.key});

  @override
  _ApplyNowScreenState createState() => _ApplyNowScreenState();
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
        title: const Text('Apply Now'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadPortfolio,
                  child: const Text('Upload Portfolio'),
                ),
                if (_portfolioFile != null) Text(_portfolioFile!.path),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _videoLinkController,
                  decoration: const InputDecoration(labelText: 'Video Link'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadPhoto,
                  child: const Text('Upload Photograph'),
                ),
                if (_photoFile != null) Image.file(_photoFile!, height: 200.0),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
