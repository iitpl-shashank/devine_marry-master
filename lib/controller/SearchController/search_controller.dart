import 'package:devine_marry/models/home/match_preference_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repo/search_repo.dart';
import '../../utils/app_constants.dart';

class SearchUserController extends GetxController {
  final SearchRepo searchRepo;
  final SharedPreferences sharedPreferences;
  RxString searchQuery = ''.obs;
  RxList<User> searchResultUsers = <User>[].obs;

  SearchUserController({
    required this.searchRepo,
    required this.sharedPreferences,
  });

  Future<void> searchUsersbyKeyword() async {
    try {
      // showLoading();
      searchResultUsers.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await searchRepo.searchUsers(
        keyword: searchQuery.value,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        searchResultUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print(
            "Filtered Users: ${searchResultUsers.map((user) => user.id).toList()}");
        // hideLoading();
      } else {
        // hideLoading();
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      // hideLoading();
      print("Exception in getUserList: $e");
    }
  }
}
