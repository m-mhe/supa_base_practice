import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageDataDeleteController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<void> deleteTheImage({required String path, required int id}) async {
    _loading = true;
    update();
    await Supabase.instance.client.storage.from("ImageStore").remove([path]);
    await Supabase.instance.client.from("images").delete().eq("id", id);
    _loading = false;
    update();
  }
}
