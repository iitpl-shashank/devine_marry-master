import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repo/profile_repo.dart';
import '../../helper/route_helper.dart';
import '../../models/profile/profile_model.dart';
import '../../utils/app_constants.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo;
  final SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;

  final String defaultProfileImage =
      'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg';

  ProfileController({
    required this.profileRepo,
    required this.sharedPreferences,
  });

  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);

  final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      final response = await profileRepo.getProfile(token: token);

      if (response.statusCode == 200 && response.body['status'] == true) {
        profile.value = ProfileModel.fromJson(response.body);
        print("Profile fetched successfully: ${profile.value}");
      } else {
        print("Failed to fetch profile: ${response.body['message']}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        isLoading.value = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString(AppConstants.token) ?? "";

        await profileRepo.updateProfileImage(pickedFile.path, token);
        await fetchProfile();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error updating profile image: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void profilenavigation(String screen) {
    if (screen == "personal_details") {
      Get.toNamed(
        RouteHelper.personalDetails,
      );
    } else if (screen == "notification") {
      Get.toNamed(
        RouteHelper.notification,
      );
    } else if (screen == "family_background") {
      Get.toNamed(
        RouteHelper.familyBackground,
      );
    } else if (screen == "education_profession") {
      Get.toNamed(
        RouteHelper.educationProfessionDetail,
      );
    } else if (screen == "personality_details") {
      Get.toNamed(
        RouteHelper.personalityDetails,
      );
    } else if (screen == "preference_details") {
      Get.toNamed(
        RouteHelper.preferenceDetails,
      );
    }
  }

// Profile Update Screen Controllers

  String? lookingFor;

  void setPersonalDetails() {}

  void updateLookingFor(String value) {
    lookingFor = value;
    update();
  }
}
