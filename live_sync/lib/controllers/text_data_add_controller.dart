import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TextDataAddController extends GetxController{
  bool _loading = false;
  bool get  loading=> _loading;

  Future<void> addTextData({required String title, required String subtitle})async{
    _loading = true;
    update();
    await Supabase.instance.client.from('notes').insert({'title': title, 'subtitle': subtitle});
    _loading = false;
    update();
  }
}