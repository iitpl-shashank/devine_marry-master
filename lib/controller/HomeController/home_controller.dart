import 'dart:convert';
import 'dart:developer';

import 'package:devine_marry/data/repo/home_repo.dart';
import 'package:devine_marry/models/details/user_details_model.dart'
    as MatchedUser;
import 'package:devine_marry/widgets/common_loading.dart';
import 'package:flutter/material.dart';
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
  RxList<User> religionUsers = <User>[].obs;
  RxList<User> qualificationUsers = <User>[].obs;
  RxList<User> stateUsers = <User>[].obs;
  RxList<User> allMatchedUsers = <User>[].obs;
  RxInt currentPage = 0.obs;

  Rx<MatchedUser.UserDetailsModel> selectedUser =
      Rx<MatchedUser.UserDetailsModel>(MatchedUser.UserDetailsModel());
  final String defaultUserImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Default-Icon.jpg/500px-Default-Icon.jpg';

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
      } else if (response.statusCode == 404) {
        final Map<String, dynamic> responseBody =
            response.body is String ? jsonDecode(response.body) : response.body;
        String errorMessage = "No users found";
        if (responseBody['message'] != null &&
            responseBody['message']['error'] != null &&
            responseBody['message']['error'] is List &&
            responseBody['message']['error'].isNotEmpty) {
          errorMessage = responseBody['message']['error'][0];
        }
        Get.snackbar("Error : ", errorMessage,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> getUserDetails({required String userId}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUserDetails(
        userId: userId,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        MatchedUser.UserDetailsModel userModel =
            MatchedUser.userDetailsModelFromJson(response.bodyString ?? "");
        selectedUser.value = userModel;
        log("Selected User UserModel Response: ${response.bodyString}");
        log("Selected User: ${selectedUser.value.data}");

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

  Future<void> sendInterestToUser(
      {required int interestingId, required String myUserId}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.sendInterestToUser(
        interestingId: interestingId,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      log("Response code : ${response.statusCode}");
      log("Response body : ${response.bodyString}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Request sent successfully.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await getUserDetails(
          userId: myUserId,
        );
        update();
      } else {
        print("Error abhay : ${response.statusText}");
      }
    } catch (e) {
      print("Exception in sendInterestToUser: $e");
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
      log("Response fffff : ${response.bodyString}");
      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        myStateUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print(
            "Filtered Users: ${myStateUsers.map((user) => user.id).toList()}");
      } else {
        print("Error: EEE ${response.statusText}");
      }
    } catch (e) {
      print("Exception in getUserList: $e");
    }
  }

  Future<void> getReligionUserList() async {
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "religion",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        religionUsers.value = matchPreferenceModel.data?.users ?? [];
        update();
        hideLoading();
        print(
            "Filtered Users: ${religionUsers.map((user) => user.id).toList()}");
      } else {
        hideLoading();
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      hideLoading();
      print("Exception in getUserList: $e");
    }
  }

  Future<void> getQualificationUserList() async {
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "highest_qualification",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        qualificationUsers.value = matchPreferenceModel.data?.users ?? [];
        update();
        hideLoading();
        print(
            "Filtered Users: ${qualificationUsers.map((user) => user.id).toList()}");
      } else {
        hideLoading();
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      hideLoading();
      print("Exception in getUserList: $e");
    }
  }

  Future<void> getStateUserList() async {
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "state",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        stateUsers.value = matchPreferenceModel.data?.users ?? [];
        update();
        hideLoading();
        print("Filtered Users: ${stateUsers.map((user) => user.id).toList()}");
      } else {
        hideLoading();
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      hideLoading();
      print("Exception in getUserList: $e");
    }
  }

  Future<void> getAllMatchedUserList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      Response response = await homeRepo.getUsersList(
        filter: "all",
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        MatchPreferenceModel matchPreferenceModel =
            matchPreferenceModelFromJson(response.bodyString ?? "");

        allMatchedUsers.value = matchPreferenceModel.data?.users ?? [];
        update();

        print(
            "Filtered Users: ${allMatchedUsers.map((user) => user.id).toList()}");
      } else {
        print("Error: ${response.statusText}");
      }
    } catch (e) {
      print("Exception in getUserList: $e");
    }
  }

  Future<void> rejectInterestRequest({
    required int id,
    required String myUserId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Response response = await homeRepo.rejectRequest(
        id: id.toString(),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            response.body is String ? jsonDecode(response.body) : response.body;
        if (responseBody['success'] == true) {
          Get.snackbar(
            "Success",
            responseBody['message'] ?? "Interest rejected successfully.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            responseBody['message'] ?? "Failed to reject interest.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to reject interest. ${response.statusText}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Exception: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      hideLoading();
      await getUserDetails(
        userId: myUserId,
      );
      update();
    }
  }

  Future<void> acceptInterestRequest({
    required int id,
    required String myUserId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Response response = await homeRepo.acceptRequest(
        id: id.toString(),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            response.body is String ? jsonDecode(response.body) : response.body;
        if (responseBody['success'] == true) {
          Get.snackbar(
            "Success",
            responseBody['message'] ?? "Interest accepted successfully.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            responseBody['message'] ?? "Failed to accept interest.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to accept interest. ${response.statusText}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Exception: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      hideLoading();
      await getUserDetails(
        userId: myUserId,
      );
      update();
    }
  }
}
