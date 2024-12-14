import 'package:get/get.dart';
import'package:supabase_flutter/supabase_flutter.dart';

class TextDataDeleteController extends GetxController{
  bool _loading = false;
  bool get loading => _loading;

  Future<void> deleteTextData({required int id}) async{
    _loading = true;
    update();
    await Supabase.instance.client.from('notes').delete().eq('id', id);
    _loading =false;
    update();
  }
}