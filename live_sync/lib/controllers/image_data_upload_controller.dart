import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageDataUploadController extends GetxController{
  bool _loading = false;
  bool get loading => _loading;

  Future<void> uploadAnImage({required File? imageFile}) async{
    if(imageFile == null){
      return;
    }else{
      _loading = true;
      update();
      final DateTime fieName = DateTime.now();
      final String path = "uploads/$fieName";
      await Supabase.instance.client.storage.from("ImageStore").upload(path, imageFile);
      final String imageUrl = Supabase.instance.client.storage.from("ImageStore").getPublicUrl(path);
      await Supabase.instance.client.from("images").insert({"image_url":imageUrl, "file_path":path});
      _loading = false;
      update();
    }
  }
}