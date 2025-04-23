import 'package:devine_marry/data/repo/home_repo.dart';
import 'package:devine_marry/models/profile/profile_model.dart' as profile;
import 'package:get/get.dart';
import '../../helper/route_helper.dart';
import '../../models/home/match_preference_model.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  RxList<User> matchedUsers = <User>[].obs;
  Rx<profile.ProfileModel?> selectedUser = Rx<profile.ProfileModel?>(null);

  void homeUserNavigation({required String id}) {
    Get.toNamed(RouteHelper.userDetailsScreen, arguments: id);
  }

  void clearSelectedUser() {
    selectedUser.value = null;
  }

  Future<void> getUsersBasedOnPreference({required String filter}) async {
    try {
      Response response = await homeRepo.getMatchedUsers(filter);

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        matchedUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print("Matched Users: ${matchedUsers.map((user) => user.id).toList()}");
      } else {
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> getUserDetails({required String userId}) async {
    try {
      clearSelectedUser();
      Response response = await homeRepo.getUserDetails(userId);

      if (response.statusCode == 200) {
        profile.ProfileModel profileModel =
            profile.profileModelFromJson(response.bodyString ?? "");
        selectedUser.value = profileModel;

        update();
      } else {
        print("Error: ${response.bodyString}");
      }
    } catch (e) {
      print("Exception in getUserDetails: $e");
    }
  }
}
