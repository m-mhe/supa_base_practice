import 'package:get/get.dart';
import 'package:live_sync/controllers/image_data_upload_controller.dart';
import 'package:live_sync/controllers/text_data_add_controller.dart';
import 'controllers/text_data_delete_controller.dart';
import 'controllers/text_data_edit_controller.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(TextDataAddController());
    Get.put(TextDataDeleteController());
    Get.put(TextDataEditController());
    Get.put(ImageDataUploadController());
  }
}