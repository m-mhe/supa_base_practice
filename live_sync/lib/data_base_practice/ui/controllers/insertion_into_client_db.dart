import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertionIntoClientDb extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<void> insert({required String name, required String email}) async {
    _loading = true;
    update();
    await Supabase.instance.client.from('client').insert(
      {
        'name': name,
        'email': email,
      }
    );
    _loading = false;
    update();
  }
}
