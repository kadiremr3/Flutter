import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:nook/controllers/authController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
