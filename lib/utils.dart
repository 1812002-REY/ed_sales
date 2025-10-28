import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(BuildContext context) async {
  final picker = ImagePicker();
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF424242),
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text(
                'Take a Photo',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  // handle the captured image (upload/save)
                  print('Camera image path: ${image.path}');
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text(
                'Choose from Gallery',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  // handle the selected image
                  print('Gallery image path: ${image.path}');
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

enum DocumentType {
  tinNumber,
  invoice,
  businessLicence,
  customerInfo,
  paySlip,
  unknown,
}
