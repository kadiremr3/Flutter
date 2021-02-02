import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/controllers/book_controller.dart';
import 'package:nook/controllers/userController.dart';
import 'package:nook/views/listOfBooks.dart';
import 'package:nook/views/loginPage.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(initState: (_) async {
      Get.put<UserController>(UserController());
    }, builder: (_) {
      if (Get.find<AuthController>().user != null) {
        return ListOfBooks();
      } else {
        return Login();
      }
    });
  }
}
