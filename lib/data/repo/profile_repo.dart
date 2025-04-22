import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_constants.dart';
import '../../utils/themes/app_colors.dart';
import '../api/api.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({
    required this.apiClient,
  });

  Future<Response> getUserAttributes() async {
    return await apiClient.postData(AppConstants.userAttribute, {});
  }

  Future<Response> getProfile({required String token}) async {
    try {
      Response response = await apiClient.getData(
          AppConstants.getProfileDetails,
          method: 'GET',
          headers: {'Authorization': 'Bearer $token'});
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
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update profile image: ${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error in updateProfileImage: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> updateProfileDetails({
    required Map<String, dynamic> data,
    required String type,
  }) async {
    try {
      if (type == "educational") {
        data = {
          "step": "educational",
          "degree": data["degree"] ?? null,
          "highest_qualification": data["highest_qualification"] ?? 1,
          "institute": data["institute"] ?? "",
          "starting_year": data["starting_year"] ?? "",
          "ending_year": data["ending_year"] ?? "",
          "company": data["company"] ?? "",
          "designation": data["designation"] ?? "",
          "monthly_income": data["monthly_income"] ?? 0,
          "experience": data["experience"] ?? 0,
        };
      } else if (type == "family") {
        data = {
          "step": "family",
          "father_name": data["father_name"] ?? "",
          "father_profession": data["father_profession"] ?? "",
          "mother_name": data["mother_name"] ?? "",
          "mother_profession": data["mother_profession"] ?? "",
          "number_of_siblings": data["number_of_siblings"] ?? 0,
        };
      }

      Response response = await apiClient.postData(
        AppConstants.profileUpdate,
        data,
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Profile details updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update profile details: ${response.body}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error in updateProfileDetails: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
      print("Error in updateProfileDetails: $e");
    }
  }
}
