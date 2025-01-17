import 'package:get/get.dart';
import 'package:live_sync/data_base_practice/ui/controllers/insertion_into_client_db.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>InsertionIntoClientDb(), fenix: true);
  }

}