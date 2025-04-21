import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_constants.dart';
import '../../utils/themes/app_colors.dart';
import '../api/api.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({
    required this.apiClient,
  });

  Future<Response> getProfile({required String token}) async {
    try {
      Response response = await apiClient.getData(
        AppConstants.getProfileDetails,
        method: 'GET',
      );
      print("Get Profile Response: ${response.body}");
      return response;
    } catch (e) {
      print("Error in getProfile: $e");
      rethrow;
    }
  }

  Future<void> updateProfileImage(String filePath, String token) async {
    try {
      // Create a multipart request
      String url = AppConstants.baseUrl + AppConstants.updateProfileImage;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Profile image updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onPrimary,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update profile image: ${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red.withOpacity(0.8),
          colorText: AppColors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error in updateProfileImage: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red.withOpacity(0.8),
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
