import 'package:get/get.dart';
import '../../helper/route_helper.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void navigateToNotification() {
    Get.toNamed(
      RouteHelper.notification,
    );
  }

  void navigateToMenu() {
    Get.toNamed(
      RouteHelper.menu,
    );
  }
}
