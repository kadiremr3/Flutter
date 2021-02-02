import 'package:get/get.dart';
import 'package:nook/controllers/authController.dart';
import 'package:nook/models/books.dart';
import 'package:nook/services/database.dart';

class BookController extends GetxController {
  Rx<List<Books>> bookList = Rx<List<Books>>();

  List<Books> get books => bookList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user.uid;
    bookList.bindStream(Database().bookStream(uid));
    super.onInit();
  }

  final dropDownHintText = "Choose a field".obs;
  final fieldValue = "null".obs;
}
