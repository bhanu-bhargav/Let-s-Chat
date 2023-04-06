import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final void Function(File pickedImage) imagePickedFn;

  UserImagePicker(this.imagePickedFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  
  void _pickImage() async{
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickedFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[900],
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage, 
          icon: const Icon(Icons.image), 
          label: const Text('Add Image'))
      ],
    );
  }
}