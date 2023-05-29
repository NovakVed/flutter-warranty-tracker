import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickFileToAddModal extends StatefulWidget {
  const PickFileToAddModal({Key? key}) : super(key: key);

  @override
  State<PickFileToAddModal> createState() => _PickFileToAddModalState();
}

class _PickFileToAddModalState extends State<PickFileToAddModal> {
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  late String _filePath;

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      // TODO do Something with that file
      // setState(() {
      //   _attachments.add(pick.path);
      // });
    }
  }

  void _openCamera() async {
    final picker = ImagePicker();
    final camera = await picker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      // TODO do Something with that file
      // setState(() {
      //   _attachments.add(pick.path);
      // });
    }
  }

  void _openFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 40.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Add Receipt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 12.0,
              bottom: 24.0,
            ),
            child: Text(
              'Choose what type of receipt you want to add',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          ListTile(
            title: const Text('Take a photo'),
            leading: const Icon(Icons.camera_alt_outlined),
            onTap: _openCamera,
          ),
          ListTile(
            title: const Text('Pick from Gallery'),
            leading: const Icon(Icons.image_outlined),
            onTap: _openImagePicker,
          ),
          ListTile(
            title: const Text('Upload PDF'),
            leading: const Icon(Icons.upload_file_outlined),
            onTap: _openFile,
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
