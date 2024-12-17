import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_sync/controllers/image_data_upload_controller.dart';
import 'package:live_sync/ui/widgets/bottom_pop_up_message.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? imageFile;
  String? fileType;

  Future<void> _pick() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      fileType = pickedImage.mimeType;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFile == null
                ? const Text('Pick an image to upload')
                : SizedBox(
                    width: MediaQuery.sizeOf(context).width - 10,
                    height: MediaQuery.sizeOf(context).width - 10,
                    child: Image.file(imageFile!, fit: BoxFit.cover,)),
            ElevatedButton(onPressed: _pick, child: const Text('Pick')),
            GetBuilder<ImageDataUploadController>(builder: (controller) {
              return Visibility(
                  visible: !controller.loading,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller.uploadAnImage(imageFile: imageFile);
                        bottomPopUpMessage(
                            context: context,
                            isError: false,
                            message: "Success!");
                      },
                      child: const Text('Upload')));
            }),
          ],
        ),
      ),
    );
  }
}
