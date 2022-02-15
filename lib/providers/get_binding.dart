import 'package:get/get.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/fav_ads_controller.dart';
import 'package:saaty_app/providers/lang_controller.dart';
import 'package:saaty_app/providers/message_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/status_product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'Orders.dart';
import 'auth_controller.dart';

class GetBinding implements Bindings {
  // final controller = Get.put(AuthController());
  // final controller1 = Get.put(ProductController());
  // final controller2 = Get.put(ProductsController());
  // final controller3 = Get.put(StatusProductController());
  // final controller4 = Get.put(FavsAdsController());
  // final controller5 = Get.put(MessageController());
  // final controller6 = Get.put(LangController());
  // final controller7 = Get.put(StorageController());
  // final controller8 = Get.put(Cart());
  // final controller9 = Get.put(Orders());

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => FavsAdsController());
    Get.lazyPut(() => StatusProductController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => LangController());
    Get.lazyPut(() => StorageController());
    Get.lazyPut(() => Cart());
    Get.lazyPut(() => Orders());


  }
}
//
// class DetailsBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<DetailsController>(() => DetailsController());
//   }
// }