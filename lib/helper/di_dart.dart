import 'package:devine_marry/controller/ConnectController/connect_controller.dart';
import 'package:devine_marry/controller/DashboardController/dashboard_controller.dart';
import 'package:devine_marry/controller/HomeController/home_controller.dart';
import 'package:devine_marry/controller/NotificationController/notification_controller.dart';
import 'package:devine_marry/controller/ProfileController/profile_controller.dart';
import 'package:devine_marry/controller/SplashScreenController/splash_controller.dart';
import 'package:devine_marry/data/repo/connect_repo.dart';
import 'package:devine_marry/data/repo/home_repo.dart';
import 'package:devine_marry/data/repo/notification_repo.dart';
import 'package:devine_marry/data/repo/search_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/AuthController/auth_controller.dart';
import '../controller/SearchController/search_controller.dart';
import '../data/api/api.dart';
import '../data/repo/auth_repo.dart';
import '../data/repo/profile_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(
      () => ApiClient(
          appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()),
      fenix: true);

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => HomeRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => SearchRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => ConnectRepo(apiClient: Get.find()), fenix: true);
  // Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  // Get.lazyPut(() => AppointmentRepo(apiClient: Get.find()));
  // Get.lazyPut(() => ClinicRepo(apiClient: Get.find()));
  // Get.lazyPut(() => DiabeticRepo(apiClient: Get.find()));

  /// Controller
  Get.lazyPut(
      () => AuthController(authRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => HomeController(homeRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () =>
          SplashController(authRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => NotificationController(
          notificationRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => ProfileController(
          profileRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(() => DashboardController(), fenix: true);
  Get.lazyPut(
      () => SearchUserController(
          searchRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => ProfileController(
          profileRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => ConnectController(
          connectRepo: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  // Get.lazyPut(() => AppointmentController(appointmentRepo:  Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ClinicController(clinicRepo:  Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ProfileController(profileRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => DiabeticController(diabeticRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ChatController(clinicRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => SubsHistoryController(clinicRepo: Get.find(), apiClient: Get.find()));
}
