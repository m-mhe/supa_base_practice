import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_sync/controllers/image_data_delete_controller.dart';

class ImageShowScreen extends StatelessWidget {
  const ImageShowScreen({super.key, required this.path, required this.id, required this.imageUrl});
  final String imageUrl;
  final String path;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTE"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 10,
              height: MediaQuery.sizeOf(context).height / 1.5,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            GetBuilder<ImageDataDeleteController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.loading,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(onPressed: () async{
                    await controller.deleteTheImage(path: path, id: id);
                    await Future.delayed(const Duration(milliseconds: 500));
                    Get.back();
                  }, child: const Text("Delete")),
                );
              }
            )
          ],
        )),
      ),
    );
  }
}
