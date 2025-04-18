import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:devine_marry/data/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repo/auth_repo.dart';
import '../../helper/date_converter.dart';
import '../../helper/route_helper.dart';
import '../../models/component_models/country.dart';
import '../../models/component_models/religion.dart';
import '../../models/component_models/user_atributes.dart';
import '../../models/user/user.dart';
import '../../utils/app_constants.dart';
import '../../widgets/common_loading.dart';
import '../../widgets/custom_snack_bar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  AuthController({
    required this.authRepo,
    required this.sharedPreferences,
  });

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool _isLoginLoading = false;

  bool get isLoginLoading => _isLoginLoading;
  final loginFormKey = GlobalKey<FormState>();
  final FocusNode phoneFocus = FocusNode();

  PageController pageController = PageController();
  int currentPage = 0;

  //CreateScreenOne

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController fathersProfessionController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherProfessionController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  int? siblings = 0;
  String? numberOfSiblings;
  String? lookingFor;
  String? maritalStatus;
  String? religion;
  String? caste;
  String? country;
  String? state;
  String? dob = "";
  String? gender;
  String? profilePhoto = "";

  void updateLookingFor(String value) {
    lookingFor = value;
    update();
  }

  void updateMaritalStatusFor(String value) {
    maritalStatus = value;
    update();
  }

  void updateReligion(String value) {
    religion = value;
    update();
  }

  void updateCaste(String? value) {
    caste = value;
    update();
  }

  void updateCasteList(List<String> value) {
    prefCaste = value;
    update();
  }

  void updateCountry(String value) {
    country = value;
    update();
  }

  void updateCountryList(List<String> value) {
    prefCountry = value;
    update();
  }

  void updateState(String? value) {
    state = value;
    update();
  }

  void updateStateList(List<String> value) {
    prefState = value;
    update();
  }

  void updatePrefState(List<String> value) {
    prefState = value;
    update();
  }

  void updateDob(String value) {
    dob = value;
    value = DateConverter.formatDate(DateTime.parse(value));
    dobController.text = value;
    update();
  }

  void updateGender(String value) {
    gender = value;
    update();
  }

  void updateProfilePhoto(String value) {
    profilePhoto = value;
    update();
  }

  //EducationDetails

  TextEditingController schoolUniversityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDayController = TextEditingController();
  TextEditingController companyOrganisationController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController monthlyIncomeController = TextEditingController();

  int? experience = 0;
  String? noOfYears;
  String? highestQualification;
  String? degree;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  //PersonalityDetails

  TextEditingController hairController = TextEditingController();
  TextEditingController eyeColorController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController interestController = TextEditingController();

  String? smokingHabit;
  String? drinkingHabit;
  String? bloodGroup;
  String? complexion;
  String? disability;

  CasteResponse casteResponse = CasteResponse(castes: []);
  DegreeResponse degreeResponse = DegreeResponse(Degrees: []);
  StateResponse stateResponse = StateResponse(states: []);

  //PreferencesDetails

  TextEditingController prefAgeController = TextEditingController();
  TextEditingController prefHeightController = TextEditingController();
  List<String>? prefReligion;
  List<String>? prefCaste;
  List<String>? prefHighestQualification;
  List<String>? prefCountry;
  List<String>? prefState;
  List<String>? prefComplexion;
  String? prefSmokingHabit;
  String? prefDrinkingHabit;

  CountryResponse countryResponse = CountryResponse(countries: []);
  ReligionResponse religionResponse = ReligionResponse(religions: []);
  CasteResponse casteListResponse = CasteResponse(castes: []);

  DataModel dataModel = DataModel(
      maritalStatuses: [],
      genders: [],
      qualifications: [],
      smoking: [],
      drinking: [],
      bloodGroups: [],
      complexion: [],
      disabilities: []);

  void updateBloodGroup(String value) {
    bloodGroup = value;
    update();
  }

  void updateComplexion(String value) {
    complexion = value;
    update();
  }

  void updateSmokingHabit(String value) {
    smokingHabit = value;
    update();
  }

  void updatePrefSmokingHabit(String value) {
    prefSmokingHabit = value;
    update();
  }

  void updatePrefDrinkingHabit(String value) {
    prefDrinkingHabit = value;
    update();
  }

  void updateDrinkingHabit(String value) {
    drinkingHabit = value;
    update();
  }

  void updateDisability(String values) {
    disability = values;
    update();
  }

  void updatePrefReligion(List<String> value) {
    prefReligion = value;
    update();
  }

  void updatePrefQualification(List<String> value) {
    prefHighestQualification = value;
    update();
  }

  void updatePrefComplexion(List<String> value) {
    prefComplexion = value;
    update();
  }

  void updatePrefCountry(List<String> value) {
    prefCountry = value;
    update();
  }

  void updateHighestQualification(String value) {
    highestQualification = value;
    update();
  }

  void updateDegree(String? value) {
    degree = value;
    update();
  }

  List<LookingFor> lookingForList = [
    LookingFor(id: 1, title: 'Bridegroom'),
    LookingFor(id: 2, title: 'Bride')
  ];

  void nextPage() {
    log("Page number : ${pageController.page}");
    if (currentPage < 4) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
      currentPage = pageController.page!.toInt() + 1;
      log("Next Page number : ${currentPage.toString()}");
    }
  }

  void updatePage(int index) {
    currentPage = index;
    pageController.jumpTo(index.toDouble());
    update();
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
      currentPage = pageController.page!.toInt() - 1;
    }
  }

  void changePhoneNumber(String value) {
    phoneController.text = value;
    update();
  }

  //
  // Future<bool> isLoggedIn() async {
  //   bool value = await  authRepo.isLoggedIn();
  //   if(value){
  //     try {
  //       Response response = await authRepo.getUserData();
  //       debugPrint(response.body.toString());
  //       UserModel user = UserModel.fromJson(response.body['user']);
  //       debugPrint("User: ${user.toJson()}");
  //     } catch (e) {
  //       debugPrint("Error: $e");
  //     }
  //   } else {
  //
  //   }
  //
  //   return false;
  // }
  // DateTime? selectedDate;
  // String? formattedDate;
  // String? privacyPolicy;
  //
  // void updateDate(DateTime newDate) {
  //   selectedDate = newDate;
  //   formattedDate = SimpleDateConverter.formatDateToCustomFormat(selectedDate!);
  //   update();
  // }
  //
  // var selectedGender = 'Male'; // Observable for selected gender
  // final List<String> genderOptions = ['Male', 'Female',]; // List of options
  //
  // void updateGender(String gender) {
  //   selectedGender = gender; // Update selected gender
  //   update(); // Call update to refresh listeners (not using Obx)
  // }
  //
  // var selectedDiabetes = 'No';
  // final List<String> diabetesOptions = ['No','Yes']; // List of options
  //
  // void updateDiabetes(String val) {
  //   selectedDiabetes = val;
  //   update();
  // }
  //
  // var selectedGlasses = 'No';
  // final List<String> glassesOptions = ['No','Yes'];
  // void updateGlasses(String val) {
  //   selectedGlasses = val;
  //   update();
  // }
  //
  // var selectedBp= 'No';
  // final List<String> bpOptions = ['No','Yes'];
  //
  // void updateHealth(String val) {
  //   selectedBp = val;
  //   update();
  // }
  //
  //
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  //
  // DateTime? lastBackPressTime;
  // Future<bool> handleOnWillPop() async {
  //   final now = DateTime.now();
  //
  //   if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
  //     updateLastBackPressTime(now);
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       const SnackBar(
  //         content: Text('Press back again to exit'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     SystemNavigator.pop();
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
  //
  // Future<void> getPrivacyPolicy(String value) async {
  //
  //   _isLoginLoading = true;
  //   update();
  //   Response response = await authRepo.getPrivacyPolicy(value);
  //
  //   final Map<String, dynamic> data = response.body['data'] as Map<String, dynamic>;
  //   log(data.toString(),name: "Privacy Policy");
  //
  //   privacyPolicy = data['content'].toString();
  //   if(value == "1") {
  //     Get.to(() => PrivacyPolicy(
  //       privacyPolicy: privacyPolicy ?? "",
  //       title: "Privacy Policy",
  //     ));
  //   } else {
  //     Get.to(() => PrivacyPolicy(
  //       privacyPolicy: privacyPolicy ?? "",
  //       title: "Terms & Condition",
  //     ));
  //   }
  //   _isLoginLoading = false;
  //   update();
  // }
  //
  //
  //
  // void updateLastBackPressTime(DateTime time) {
  //   lastBackPressTime = time;
  //   update();
  // }
  //
  // ///################ Apis ########################
  //
  //
  // bool _isLoginLoading = false;
  // bool get isLoginLoading => _isLoginLoading;
  //
  // bool _isShowingBottomBar = true;
  // bool get isShowingBottomBar => _isShowingBottomBar;
  //
  //
  // void updateBottomBarVisibility(bool isVisible) {
  //   _isShowingBottomBar = isVisible;
  //   //debugPrint('Bottom bar visibility: $isVisible');
  //   update();
  // }
  Future<void> sendOtpApi() async {
    _isLoginLoading = true;
    update();
    try {
      Response response =
          await authRepo.sendOtpRepo(phoneController.text.trim());
      debugPrint("Response: ${response.body}");
      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;

        if (responseData["message"]
            .toString()
            .contains("OTP sent successfully.")) {
          String otp = responseData['otp'].toString();
          _isLoginLoading = false;
          update();
          closeSnackBar();
          showCustomSnackBar(
              responseData['message'] + responseData['otp'].toString(),
              isError: false,
              isSuccess: true);
          debugPrint("OTP: ${responseData['otp']}");
          Get.toNamed(
              RouteHelper.getOtpVerificationRoute(phoneController.text.trim()));
        } else {
          _isLoginLoading = false;
          update();
          closeSnackBar();
          showCustomSnackBar(responseData['message'], isError: true);
        }
      } else {
        print('Failed to send OTP');
      }
    } catch (e) {
      print("Error sending OTP: $e");
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getCountries() async {
    _isLoginLoading = true;
    // showLoading();
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getCountries();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        CountryResponse countries = CountryResponse.fromJson(responseData);
        countryResponse = countries;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getReligion() async {
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getreligions();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        ReligionResponse religion =
            ReligionResponse.fromJson(responseData['data']);
        religionResponse = religion;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getUserAttributes() async {
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getUserAttributes();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        DataModel userAttribute = DataModel.fromJson(responseData['data']);
        dataModel = userAttribute;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getCastes(String id) async {
    showLoading();
    updateCaste(null);
    casteResponse = CasteResponse(castes: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getCastes(id);
      if (response.body == null) {}
      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        CasteResponse castes = CasteResponse.fromJson(responseData['data']);
        casteResponse = castes;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getStates(String id) async {
    showLoading();
    updateState(null);
    stateResponse = StateResponse(states: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getstates(id);

      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        StateResponse states = StateResponse.fromJson(responseData['data']);
        stateResponse = states;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getStatesList(List<String> id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AppConstants.token) ?? "";
    print("$token");
    print("Country ids : $id");
    showLoading();
    updateStateList([]);
    stateResponse = StateResponse(states: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getStateList(
        id: id,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept' : 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        StateResponse states = StateResponse.fromJson(responseData['data']);
        stateResponse = states;
        print("Country ids : ${response.body}");
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getCasteList(List<String> id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AppConstants.token) ?? "";
    print("Caste List ID: $id");
    showLoading();
    updateCasteList([]);
    casteListResponse = CasteResponse(castes: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getCastesList(
        id: id,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept' : 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("Castes Response : ${response.body}");
      if (response.body == null) {}
      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        CasteResponse castes = CasteResponse.fromJson(responseData['data']);
        casteListResponse = castes;
        print("Castes : ${casteListResponse.castes.length}");
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getDegrees() async {
    showLoading();
    updateDegree(null);
    degreeResponse = DegreeResponse(Degrees: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getDegree();
      debugPrint(response.body.toString());
      if (response.body == null) {}
      if (response.body['success'] && response.body != null) {
        var responseData = response.body;
        DegreeResponse degrees = DegreeResponse.fromJson(responseData);
        degreeResponse = degrees;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the degree');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  //
  // Future<void> saveSubscriptionStatus(bool isActive) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isSubscriptionActive', isActive);
  // }
  //
  //
  // Future<bool> getSubscriptionStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isSubscriptionActive') ?? false;
  // }
  //
  // Future<void> verifyOtpApi(String? otp) async {
  //   ApiClient apiClient = ApiClient(
  //       appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences);
  //   if (phoneController.text.isEmpty || otp == null) {
  //     showCustomSnackBar('Phone number and OTP cannot be null', isError: true);
  //     return;
  //   }

  //   _isLoginLoading = true;
  //   update();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   final String? deviceToken = "";
  //   // await prefs.getString('FCM');
  //   //debugPrint('Device token: $deviceToken');
  //   try {
  //     Response response = await authRepo.verifyOtp(
  //         phoneController.text.trim(), otp, deviceToken);
  //     print(response);
  //     // Create a multipart request
  //     bool isSaved =
  //         await prefs.setString(AppConstants.token, response.body['token']);
  //     print(response.body['token']);
  //     apiClient.updateHeader(response.body['token']);
  //     if (response.body['status']) {
  //       closeSnackBar();
  //       log("Body==> ${response.body['user']}");
  //       UserModel user = UserModel.fromJson(response.body['user']);
  //       if (!isSaved) return;
  //       if (user.profileComplete == 0 || user.profileComplete == null) {
  //         Get.toNamed(RouteHelper.register);
  //         showCustomSnackBar(response.body['message'],
  //             isError: false, isSuccess: true);
  //       } else {
  //         Get.toNamed(RouteHelper.dashboard);
  //       }
  //     } else {
  //       showCustomSnackBar(response.body['message'], isError: true);
  //     }
  //   } catch (e) {
  //     closeSnackBar();
  //     showCustomSnackBar("Something went wrong. Please try again $e .",
  //         isError: true);
  //   } finally {
  //     _isLoginLoading = false;
  //     update();
  //   }
  // }

  Future<void> verifyOtpApi(String? otp) async {
    ApiClient apiClient = ApiClient(
        appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences);

    if (phoneController.text.isEmpty || otp == null) {
      showCustomSnackBar('Phone number and OTP cannot be null', isError: true);
      return;
    }

    _isLoginLoading = true;
    update();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? deviceToken = ""; // Replace with actual device token logic

    try {
      // Call the verifyOtp API
      Response response = await authRepo.verifyOtp(
          phoneController.text.trim(), otp, deviceToken);

      print("API Response: ${response.body}");

      // Extract and save the token
      String? token = response.body['token'];
      if (token == null || token.isEmpty) {
        print("❌ Token is null or empty in the response");
        showCustomSnackBar("Failed to retrieve token. Please try again.",
            isError: true);
        return;
      }

      // Save the token to SharedPreferences
      bool isSaved = await prefs.setString(AppConstants.token, token);
      if (!isSaved) {
        print("❌ Failed to save the token");
        showCustomSnackBar("Failed to save token. Please try again.",
            isError: true);
        return;
      }

      print("✅ Token saved successfully: $token");

      // Update the API client header with the new token
      apiClient.updateHeader(token);
      print("Saved Token: ${prefs.getString(AppConstants.token)}");

      // Ensure the header is updated before making any API calls
      print("Updated Headers token: ${apiClient.token}");

      // Handle the response and navigate accordingly
      if (response.body['status']) {
        closeSnackBar();
        log("Body==> ${response.body['user']}");
        UserModel user = UserModel.fromJson(response.body['user']);

        if (user.profileComplete == 0 || user.profileComplete == null) {
          // Fetch required data before navigating
          await fetchInitialData(); // Ensure all required data is fetched
          Get.toNamed(
              RouteHelper.register); // Navigate to the registration screen
          showCustomSnackBar(response.body['message'],
              isError: false, isSuccess: true);
        } else {
          // Navigate to the dashboard
          Get.toNamed(RouteHelper.dashboard);
        }
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }
  // Future<void> verifyOtpApi(String? otp) async {
  //   ApiClient apiClient = ApiClient(
  //       appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences);

  //   if (phoneController.text.isEmpty || otp == null) {
  //     showCustomSnackBar('Phone number and OTP cannot be null', isError: true);
  //     return;
  //   }

  //   _isLoginLoading = true;
  //   update();

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? deviceToken = ""; // Replace with actual device token logic

  //   try {
  //     // Call the verifyOtp API
  //     Response response = await authRepo.verifyOtp(
  //         phoneController.text.trim(), otp, deviceToken);

  //     print("API Response: ${response.body}");

  //     // Extract and save the token
  //     String? token = response.body['token'];
  //     if (token == null || token.isEmpty) {
  //       print("❌ Token is null or empty in the response");
  //       showCustomSnackBar("Failed to retrieve token. Please try again.",
  //           isError: true);
  //       return;
  //     }

  //     // Save the token to SharedPreferences
  //     bool isSaved = await prefs.setString(AppConstants.token, token);
  //     if (!isSaved) {
  //       print("❌ Failed to save the token");
  //       showCustomSnackBar("Failed to save token. Please try again.",
  //           isError: true);
  //       return;
  //     }

  //     print("✅ Token saved successfully: $token");

  //     // Update the API client header with the new token
  //     apiClient.updateHeader(token);

  //     // Handle the response and navigate accordingly
  //     if (response.body['status']) {
  //       closeSnackBar();
  //       log("Body==> ${response.body['user']}");
  //       UserModel user = UserModel.fromJson(response.body['user']);

  //       if (user.profileComplete == 0 || user.profileComplete == null) {
  //         // Navigate to the registration screen
  //         Get.toNamed(RouteHelper.register);
  //         showCustomSnackBar(response.body['message'],
  //             isError: false, isSuccess: true);
  //       } else {
  //         // Navigate to the dashboard
  //         Get.toNamed(RouteHelper.dashboard);
  //       }
  //     } else {
  //       showCustomSnackBar(response.body['message'], isError: true);
  //     }
  //   } catch (e) {
  //     closeSnackBar();
  //     showCustomSnackBar("Something went wrong. Please try again. $e",
  //         isError: true);
  //   } finally {
  //     _isLoginLoading = false;
  //     update();
  //   }
  // }

  Future<void> fetchInitialData() async {
    try {
      // Fetch required data sequentially
      await getCountries();
      await getReligion();
      await getUserAttributes();
      // Add other API calls if needed
    } catch (e) {
      print("❗ Error fetching initial data: $e");
      showCustomSnackBar("Failed to fetch initial data. Please try again.",
          isError: true);
    }
  }

  void updateSiblings(int i) {
    siblings = i;
    numberOfSiblings = siblings.toString();
    update();
  }

  void updateExperience(int i) {
    experience = i;
    noOfYears = experience.toString();
    update();
  }

  Future<void> registerUserPreferences({
    required String token,
    required String url,
    required int smokingStatus,
    required int drinkingStatus,
    required List<int> religionList,
    required List<int> casteList,
    required List<int> countryList,
    required List<int> stateList,
    required List<int> qualificationList,
    required List<int> complexionsList,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
      'POST',
      Uri.parse(url),
    );

    request.body = json.encode({
      "step": "preferences",
      "age": prefAgeController.text,
      "height": prefHeightController.text,
      "religion": religionList,
      "smoking_status": smokingStatus,
      "drinking_status": drinkingStatus,
      "caste": casteList,
      "country": countryList,
      "state": stateList,
      "qualifications": qualificationList,
      "complexions": complexionsList,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Get.toNamed(RouteHelper.successFullRegisterationScreen);
        print("✅ Success: $responseBody");
      } else {
        print("❌ Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❗ Exception: $e");
    }
  }

  void onCompleteRegistration() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(RouteHelper.dashboard);
    });
  }

  Future<bool> registerUser(String updateType) async {
    showLoading();
    final String url = AppConstants.baseUrl +
        AppConstants.register; // Replace with your API URL

    // Image file (Replace with actual file picker logic)
    File imageFile = File(profilePhoto ?? ""); // Replace with actual image path

    // Create a request
    var request = http.MultipartRequest("POST", Uri.parse(url));
    String token = await sharedPreferences.getString(AppConstants.token) ?? "";

    request.headers.addAll({
      "Authorization": "Bearer $token", // Replace with actual token
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
    });

    Map<String, dynamic> finalMap = {};

    if (updateType == "register") {
      finalMap = {
        "step": "register",
        "looking_for": lookingForList
            .firstWhere((element) => element.title == lookingFor)
            .id
            .toString(),
        "marital_status": dataModel.maritalStatuses
            .firstWhere((element) => element.title == maritalStatus)
            .id
            .toString(),
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "religions": religionResponse.religions
            .firstWhere((element) => element.name == religion)
            .id
            .toString(),
        if (casteResponse.castes.isNotEmpty)
          "caste": casteResponse.castes
              .firstWhere((element) => (element.name ?? "") == caste)
              .id
              .toString(),
        "country": countryResponse.countries
            .firstWhere((element) => (element.name ?? "") == country)
            .id
            .toString(),
        "state": stateResponse.states
            .firstWhere((element) => (element.name ?? "") == state)
            .id
            .toString(),
        "birthDate": dobController.text,
        "gender": dataModel.genders
            .firstWhere((element) => (element.gender ?? "") == gender)
            .id
            .toString(),
        "father_name": fathersNameController.text,
        "father_profession": fathersProfessionController.text,
        "mother_name": motherNameController.text,
        "mother_profession": motherProfessionController.text,
        "number_of_siblings": (numberOfSiblings ?? "").toString(),
      };
    } else if (updateType == "basicInfo") {
      bool isHighSchoolOrIntermediate = highestQualification != "High School" &&
          highestQualification != "Intermediate";
      finalMap = {
        "step": "basicInfo",
        "highest_qualification": (dataModel.qualifications
                .firstWhere(
                    (element) => (element.name ?? "") == highestQualification)
                .id)
            .toString(),
        "institute": schoolUniversityController.text,
        if (isHighSchoolOrIntermediate)
          "degree": degreeResponse.Degrees.firstWhere(
              (element) => (element.name ?? "") == degree).id.toString(),
        "starting_year": startDateController.text,
        "ending_year": endDayController.text,
        "company": companyOrganisationController.text,
        "designation": designationController.text,
        "monthly_income": monthlyIncomeController.text,
        "experience": noOfYears,
      };
    } else if (updateType == "physicalAttributeInfo") {
      finalMap = {
        "step": "physicalAttributeInfo",
        "hair_color": hairController.text,
        "eye_color": eyeColorController.text,
        "bio": bioController.text,
        "height": heightController.text,
        "weight": weightController.text,
        "interests_hobbies": interestController.text,
        "smoking_habit": dataModel.smoking
            .firstWhere((element) => (element.name ?? "") == smokingHabit)
            .id
            .toString(),
        "drinking_habit": dataModel.drinking
            .firstWhere((element) => (element.name ?? "") == drinkingHabit)
            .id
            .toString(),
        "blood_group": dataModel.bloodGroups
            .firstWhere((element) => (element.name ?? "") == bloodGroup)
            .id
            .toString(),
        "complexion": dataModel.complexion
            .firstWhere((element) => (element.name ?? "") == complexion)
            .id
            .toString(),
        "disabilities": dataModel.disabilities
            .firstWhere((dis) => dis.name == disability)
            .id,
      };
    } else {
      List<int> Religion = [];
      List<int> HighestQualification = [];
      List<int> Country = [];

      List<int> State = [];
      List<int> Caste = [];
      List<int> Complexions = [];

      religionResponse.religions!.forEach((religion) {
        if (prefReligion!.contains(religion.name)) {
          Religion.add(religion.id);
        }
      });

      dataModel.qualifications.forEach((qualification) {
        if (prefHighestQualification!.contains(qualification.name)) {
          HighestQualification.add(qualification.id.toInt());
        }
      });

      countryResponse.countries.forEach((country) {
        if (prefCountry!.contains(country.name)) {
          Country.add(country.id.toInt());
        }
      });

      stateResponse.states.forEach((state) {
        if (prefState!.contains(state.name)) {
          State.add(state.id.toInt());
        }
      });

      casteResponse.castes.forEach((caste) {
        if (prefCaste!.contains(caste.name)) {
          Caste.add(caste.id.toInt());
        }
      });

      dataModel.complexion.forEach((c) {
        if (prefComplexion!.contains(c.name)) {
          Complexions.add(c.id.toInt());
        }
      });

      int smokingStatusPref = dataModel.smoking
          .firstWhere((element) => (element.name ?? "") == prefSmokingHabit)
          .id;

      int drinkingStatusPref = dataModel.drinking
          .firstWhere((element) => (element.name ?? "") == prefDrinkingHabit)
          .id;

      registerUserPreferences(
          token: token,
          url: url,
          smokingStatus: smokingStatusPref,
          drinkingStatus: drinkingStatusPref,
          religionList: Religion,
          casteList: Caste,
          countryList: Country,
          stateList: State,
          qualificationList: HighestQualification,
          complexionsList: Complexions);

      return true;

      // finalMap = {
      //   "step": "preferences",
      // "age": 25,
      // "height": 25,
      // "religion[]": 2, 3,
      // "smoking_status": 1,
      // "drinking_status": 1,
      // "caste[]": Caste,
      //   "country[]": [2],
      //   "state[]": [8, 9],

      //   "qualifications[]": HighestQualification,
      //   "complexions[]": Complexions
      // };

      // finalMap = {
      //   "step": "preferences",
      //   "age": prefAgeController.text,
      //   "height": prefHeightController.text,
      //   "religion[]": Religion.join(",") ,
      //   "smoking_status": dataModel.smoking
      //       .firstWhere((element) => (element.name ?? "") == prefSmokingHabit)
      //       .id
      //       .toString(),
      //   "drinking_status": dataModel.drinking
      //       .firstWhere((element) => (element.name ?? "") == prefDrinkingHabit)
      //       .id
      //       .toString(),
      //   "caste[]": Caste,
      //   "country[]": Country,
      //   "state[]": State.join(","),
      //   "qualifications[]": HighestQualification.join(","),
      //   "complexions": "2","3",
      // };
    }

    log("Final Map: $finalMap\n===>");
    // Add fields
    request.fields.addAll(finalMap
        .map((key, value) => MapEntry(key.toString(), value.toString() ?? "")));

    // Add image file
    if (imageFile.path.isNotEmpty && updateType == "register") {
      request.files.add(
        await http.MultipartFile.fromPath("image", imageFile.path),
      );
    }

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        hideLoading();
        print("Success: $responseData");
        if (currentPage == 4) {
          Get.toNamed(RouteHelper.successFullRegisterationScreen);
        } else {
          nextPage();
        }
        return true;
      } else {
        hideLoading();
        print("Error: ${response.statusCode} - $responseData");
        return false;
      }
    } catch (e) {
      hideLoading();
      print("Request failed: $e");
      return false;
    } finally {
      return false;
    }
  }

//
//
// bool _userDataLoading = false;
// bool get userDataLoading => _userDataLoading;
//
//
// UserData? _userData;
// PatientData? _patientData;
//
// UserData? get userData => _userData;
// PatientData? get patientData => _patientData;
//
// Future<ApiResponse?> userDataApi() async {
//   // LoadingDialog.showLoading(message: "Please wait...");
//   _userDataLoading = true;
//   _userData = null;
//   _patientData = null;
//   update();
//   Response response = await authRepo.getUserData();
//   if (response.statusCode == 200) {
//     Map<String, dynamic> responseData = response.body;
//     ApiResponse apiResponse = ApiResponse.fromJson(responseData);
//     _userData = apiResponse.userData;
//     _patientData = apiResponse.patientData;
//     bool isSubscriptionActive = (responseData['subscriptionArray']['status'] ??false) as bool;
//     debugPrint("Subscription status: ${responseData['subscriptionArray']['status']}");
//     await saveSubscriptionStatus(isSubscriptionActive);
//   } else {
//
//   }
//   _userDataLoading = false;
//   // LoadingDialog.hideLoading();
//   update();
//   return ApiResponse(userData: _userData, patientData: _patientData); // Return the combined response
// }

  void checkCreateAccountScreen() {
    if ((lookingFor ?? "").isNotEmpty &&
        (maritalStatus ?? "").isNotEmpty &&
        (country ?? "").isNotEmpty &&
        ((caste ?? "").isNotEmpty || casteResponse.castes.isEmpty) &&
        (religion ?? "").isNotEmpty &&
        (firstNameController.text ?? "").isNotEmpty &&
        (lastNameController.text ?? "").isNotEmpty &&
        (fathersProfessionController.text ?? "").isNotEmpty &&
        (fathersNameController.text ?? "").isNotEmpty &&
        (motherNameController.text ?? "").isNotEmpty &&
        (motherProfessionController.text ?? "").isNotEmpty &&
        ((numberOfSiblings ?? "").isNotEmpty &&
            (numberOfSiblings ?? "") != "0") &&
        (dobController.text).isNotEmpty &&
        (gender ?? "").isNotEmpty &&
        (profilePhoto ?? "").isNotEmpty) {
      registerUser("register");
    } else {
      if (numberOfSiblings == "0") {
        closeSnackBar();
        showCustomSnackBar("Number of siblings should be greater than 0",
            isError: true);
      } else if (dobController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select date of birth", isError: true);
      } else if ((profilePhoto ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select profile photo", isError: true);
      } else if ((gender ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select gender", isError: true);
      } else if ((maritalStatus ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select marital status", isError: true);
      } else if ((country ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select a country", isError: true);
      } else if ((state ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select a state", isError: true);
      } else if ((caste ?? "").isEmpty && (casteResponse.castes.isNotEmpty)) {
        closeSnackBar();
        showCustomSnackBar("Please select a caste", isError: true);
      } else if ((religion ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select a religion", isError: true);
      } else if (firstNameController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your first name", isError: true);
      } else if (lastNameController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your last name", isError: true);
      } else if (fathersNameController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your father's name", isError: true);
      } else if (fathersProfessionController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your father's profession",
            isError: true);
      } else if (motherNameController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your mother's name", isError: true);
      } else if (motherProfessionController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your mother's profession",
            isError: true);
      }
    }
  }

  void checkEducationScreen() {
    bool isHighSchoolOrIntermediate = highestQualification != "High School" &&
        highestQualification == "Intermediate";

    if ((highestQualification ?? "").isNotEmpty &&
        (!isHighSchoolOrIntermediate || (degree ?? "").isNotEmpty) &&
        (schoolUniversityController.text ?? "").isNotEmpty &&
        (startDateController.text ?? "").isNotEmpty &&
        (endDayController.text ?? "").isNotEmpty &&
        (companyOrganisationController.text ?? "").isNotEmpty &&
        (designationController.text ?? "").isNotEmpty &&
        (monthlyIncomeController.text ?? "").isNotEmpty &&
        ((noOfYears ?? "").isNotEmpty && (noOfYears ?? "") != "0")) {
      registerUser("basicInfo");
    } else {
      if ((highestQualification ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select highest qualification",
            isError: true);
      } else if (isHighSchoolOrIntermediate && (degree ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select degree", isError: true);
      } else if (schoolUniversityController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your school/university name",
            isError: true);
      } else if (startDateController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select start date", isError: true);
      } else if (endDayController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select end date", isError: true);
      } else if (companyOrganisationController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your company/organisation name",
            isError: true);
      } else if (designationController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your designation", isError: true);
      } else if (monthlyIncomeController.text.isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your monthly income", isError: true);
      } else if ((noOfYears ?? "").isEmpty || (noOfYears ?? "") == "0") {
        closeSnackBar();
        showCustomSnackBar("Please enter experience", isError: true);
      }
    }
  }

  void checkPersonalityScreen() {
    if ((hairController.text ?? "").isNotEmpty &&
        (eyeColorController.text ?? "").isNotEmpty &&
        (bioController.text ?? "").isNotEmpty &&
        (heightController.text ?? "").isNotEmpty &&
        (weightController.text ?? "").isNotEmpty &&
        (interestController.text ?? "").isNotEmpty &&
        (smokingHabit ?? "").isNotEmpty &&
        (drinkingHabit ?? "").isNotEmpty &&
        (bloodGroup ?? "").isNotEmpty &&
        (complexion ?? "").isNotEmpty &&
        // (prefCountry ?? []).isNotEmpty &&
        // (prefHighestQualification ?? []).isNotEmpty &&
        // (prefReligion ?? []).isNotEmpty &&
        (disability ?? "").isNotEmpty) {
      registerUser("physicalAttributeInfo");
    } else {
      if ((hairController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your hair color", isError: true);
      } else if ((eyeColorController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your eye color", isError: true);
      } else if ((bioController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your bio", isError: true);
      } else if ((heightController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your height", isError: true);
      } else if ((weightController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your weight", isError: true);
      } else if ((interestController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please enter your interest", isError: true);
      } else if ((smokingHabit ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select smoking habit", isError: true);
      } else if ((drinkingHabit ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select drinking habit", isError: true);
      } else if ((bloodGroup ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select blood group", isError: true);
      } else if ((complexion ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select complexion", isError: true);
        // } else if ((prefCountry ?? []).isEmpty) {
        //   closeSnackBar();
        //   showCustomSnackBar("Please select preferred country", isError: true);
        // } else if ((prefHighestQualification ?? []).isEmpty) {
        //   closeSnackBar();
        //   showCustomSnackBar("Please select preferred highest qualification",
        //       isError: true);
        // } else if ((prefReligion ?? []).isEmpty) {
        //   closeSnackBar();
        //   showCustomSnackBar("Please select preferred religion", isError: true);
      } else if ((disability ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select disability", isError: true);
      }
    }
  }

  void checkPreferencesScreen() {
    if ((prefAgeController.text ?? "").isNotEmpty &&
        (prefHeightController.text ?? "").isNotEmpty &&
        (prefReligion ?? []).isNotEmpty &&
        (prefCaste ?? []).isNotEmpty &&
        (prefSmokingHabit ?? "").isNotEmpty &&
        (prefDrinkingHabit ?? "").isNotEmpty &&
        (prefCountry ?? []).isNotEmpty &&
        (prefState ?? []).isNotEmpty &&
        (prefHighestQualification ?? []).isNotEmpty &&
        (prefComplexion ?? []).isNotEmpty) {
      registerUser("preferences");
    } else {
      if ((prefAgeController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select your age.", isError: true);
      } else if ((prefHeightController.text ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select your height.", isError: true);
      } else if ((prefSmokingHabit ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select Smoking habit", isError: true);
      } else if ((prefDrinkingHabit ?? "").isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select drinking habit", isError: true);
      } else if ((prefComplexion ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select complexion", isError: true);
      } else if ((prefCountry ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select preferred country", isError: true);
      } else if ((prefState ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select preferred state", isError: true);
      } else if ((prefHighestQualification ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select preferred highest qualification",
            isError: true);
      } else if ((prefReligion ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select preferred religion", isError: true);
      } else if ((prefCaste ?? []).isEmpty) {
        closeSnackBar();
        showCustomSnackBar("Please select preferred caste.", isError: true);
      }
    }
  }
}
