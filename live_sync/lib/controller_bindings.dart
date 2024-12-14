import 'package:get/get.dart';
import 'package:live_sync/controllers/text_data_add_controller.dart';
import 'controllers/text_data_delete_controller.dart';
import 'controllers/text_data_edit_controller.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>TextDataAddController(), fenix: true,);
    Get.put(TextDataDeleteController());
    Get.put(TextDataEditController());
  }
}