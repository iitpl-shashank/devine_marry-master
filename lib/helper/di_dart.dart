
import 'package:devine_marry/controller/SplashScreenController/splash_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/AuthController/auth_controller.dart';
import '../data/api/api.dart';
import '../data/repo/auth_repo.dart';
import '../utils/app_constants.dart';



Future<void>   init() async {

  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));



  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  // Get.lazyPut(() => AppointmentRepo(apiClient: Get.find()));
  // Get.lazyPut(() => ClinicRepo(apiClient: Get.find()));
  // Get.lazyPut(() => DiabeticRepo(apiClient: Get.find()));



  /// Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(authRepo: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => AppointmentController(appointmentRepo:  Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ClinicController(clinicRepo:  Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ProfileController(profileRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => DiabeticController(diabeticRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => ChatController(clinicRepo: Get.find(), apiClient: Get.find()));
  // Get.lazyPut(() => SubsHistoryController(clinicRepo: Get.find(), apiClient: Get.find()));



}
