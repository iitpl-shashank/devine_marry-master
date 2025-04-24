import 'package:devine_marry/data/repo/home_repo.dart';
import 'package:devine_marry/models/details/user_details_model.dart'
    as MatchedUser;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/route_helper.dart';
import '../../models/home/match_preference_model.dart';
import '../../utils/app_constants.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;
  final SharedPreferences sharedPreferences;

  HomeController({
    required this.homeRepo,
    required this.sharedPreferences,
  });

  RxList<User> matchedUsers = <User>[].obs;
  RxList<User> latestUsers = <User>[].obs;
  RxList<User> myStateUsers = <User>[].obs;
  Rx<MatchedUser.UserDetailsModel> selectedUser =
      Rx<MatchedUser.UserDetailsModel>(MatchedUser.UserDetailsModel());

  void homeUserNavigation({required String id}) {
    Get.toNamed(RouteHelper.userDetailsScreen, arguments: id);
  }

  Future<void> getDefaultUsersBasedOnPreference() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getDefaultMatchedUsers(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

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
      Response response = await homeRepo.getUserDetails(userId);

      if (response.statusCode == 200) {
        MatchedUser.UserDetailsModel userModel =
            MatchedUser.userDetailsModelFromJson(response.bodyString ?? "");
        selectedUser.value = userModel;

        update();
      } else {
        print("Error: ${response.bodyString}");
      }
    } catch (e) {
      print("Exception in getUserDetails: $e");
    }
  }

  Future<void> getLatestUserList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "latest",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        latestUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print("Filtered Users: ${latestUsers.map((user) => user.id).toList()}");
      } else {
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      print("Exception in getUserList: $e");
    }
  }

  Future<void> getMyStateUserList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "my_state",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        myStateUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print(
            "Filtered Users: ${myStateUsers.map((user) => user.id).toList()}");
      } else {
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      print("Exception in getUserList: $e");
    }
  }
}
