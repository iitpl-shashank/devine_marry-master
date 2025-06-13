import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:devine_marry/helper/common_functions.dart';
import 'package:devine_marry/models/component_models/country.dart';
import 'package:devine_marry/models/component_models/religion.dart';
import 'package:devine_marry/widgets/common_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repo/profile_repo.dart';
import '../../helper/date_converter.dart';
import '../../helper/route_helper.dart';
import '../../models/component_models/user_atributes.dart';
import '../../models/profile/gallery_model.dart';
import '../../models/profile/profile_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/themes/app_colors.dart';
import '../AuthController/auth_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo;
  final SharedPreferences sharedPreferences;
  RxBool isLoading = false.obs;
  final AuthController authController = Get.find<AuthController>();

  final String defaultProfileImage =
      'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg';

  ProfileController({
    required this.profileRepo,
    required this.sharedPreferences,
  });
  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final ImagePicker _picker = ImagePicker();

  RxList<XFile> selectedImages = <XFile>[].obs;
  RxList<ImageData> galleryImages = <ImageData>[].obs;

  Future<void> fetchGalleryImages() async {
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";
      String? responseBody = await profileRepo.fetchGalleryImages(token: token);
      debugPrint("Response Body for Images: $responseBody");
      if (responseBody != null) {
        GalleryModel galleryModel =
            GalleryModel.fromJson(jsonDecode(responseBody));

        galleryImages.value = galleryModel.data?.images ?? [];
        update();
        hideLoading();

        Get.snackbar(
          "Success",
          "Gallery images fetched successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
          duration: const Duration(seconds: 3),
        );
      } else {
        hideLoading();
        Get.snackbar(
          "Error",
          "Failed to fetch gallery images.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      hideLoading();
      Get.snackbar(
        "Error",
        "Error in fetchGalleryImages: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
      print("Error in fetchGalleryImages: $e");
    }
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      showLoading();
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
      hideLoading();
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
        // TODO : To check if this fetchGallery is required here
        await fetchGalleryImages();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error updating profile image: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Function to select multiple images from the gallery
  Future<void> selectGalleryImages() async {
    try {
      // Open the gallery and allow the user to select multiple images
      final List<XFile>? pickedImages = await _picker.pickMultiImage();

      if (pickedImages != null && pickedImages.isNotEmpty) {
        // Filter images that exceed the size limit of 2MB
        final List<XFile> validImages = pickedImages.where((image) {
          final fileSize = File(image.path).lengthSync();
          return fileSize <= 2 * 1024 * 1024; // 2MB in bytes
        }).toList();

        if (validImages.isEmpty) {
          Get.snackbar(
            "Error",
            "All selected images exceed the size limit of 2MB.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.red,
            colorText: AppColors.white,
          );
          return;
        }

        // Update the global selectedImages variable
        selectedImages.value = validImages;

        Get.snackbar(
          "Success",
          "Images selected successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        print("No images selected.");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error selecting images: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      print("Error selecting images: $e");
    }
  }

  Future<void> uploadGalleryImages() async {
    try {
      if (selectedImages.isEmpty) {
        Get.snackbar(
          "Error",
          "No images selected to upload.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        return;
      }

      final List<XFile> imagesToUpload = selectedImages.take(5).toList();
      final List<String> filePaths =
          imagesToUpload.map((image) => image.path).toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.token) ?? "";

      isLoading.value = true;
      showLoading();
      await profileRepo.uploadGalleryImages(filePaths: filePaths, token: token);
      selectedImages.clear();

      Get.snackbar(
        "Success",
        "Images uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );

      Get.offNamed(RouteHelper.dashboard);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error uploading images: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      print("Error uploading images: $e");
    } finally {
      hideLoading();
      isLoading.value = false;
    }
  }

  void profileNavigation(String screen) {
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

// Profile Update Screen Controllers <-------------------------------------------->
//Personal Details

  String? lookingFor;
  String? religion;
  String? maritalStatus;
  String? caste;
  String? country;
  String? state;
  String? dob = "";
  String? gender;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  Future<void> setPersonalDetails() async {
    isLoading.value = true;

    firstNameController.text = profile.value?.data?.user?.firstname ?? "";
    lastNameController.text = profile.value?.data?.user?.lastname ?? "";
    log("DOB: ${profile.value?.data?.user?.birthDate.toString()}");
    dobController.text = CommonFunctions.formatDateToYMD(
        profile.value?.data?.user?.birthDate.toString() ?? "");
    setLookingFor(profile.value?.data?.user?.lookingFor ?? 1);
    setMaritalStatus(profile.value?.data?.user?.maritalStatus ?? 1);
    setReligion(profile.value?.data?.user?.religions ?? 1);
    await setCaste(
        casteId: profile.value?.data?.user?.caste ?? 1,
        religionId: profile.value?.data?.user?.religions ?? 1);
    setCountry(profile.value?.data?.user?.country ?? 2);
    await setState(
        stateId: profile.value?.data?.user?.state ?? 1,
        countryId: profile.value?.data?.user?.country ?? 2);
    setGender(profile.value?.data?.user?.gender ?? 1);
    dob = dobController.text;
    update();

    isLoading.value = false;
  }

  void setLookingFor(int id) {
    final setLookingFor = authController.lookingForList.firstWhere(
      (item) => item.id == id,
      orElse: () => LookingFor(id: 0, title: 'Unknown'),
    );
    lookingFor = setLookingFor.title;
  }

  void setMaritalStatus(int id) {
    final matchingStatus = authController.dataModel.maritalStatuses.firstWhere(
      (status) => status.id == id,
      orElse: () => MaritalStatus(id: 0, title: 'Unknown'),
    );
    maritalStatus = matchingStatus.title;
    update();
  }

  void setReligion(int id) {
    final matchingReligion =
        authController.religionResponse.religions.firstWhere(
      (status) => status.id == id,
      orElse: () =>
          Religion(id: 0, name: 'Unknown', createdAt: '', updatedAt: ''),
    );
    religion = matchingReligion.name;
    update();
  }

  Future<void> setCaste({required int casteId, required int religionId}) async {
    debugPrint("In Set Caste Function");

    await authController.getCastes(religionId.toString());
    update();
    authController.casteResponse.castes.forEach((caste) {
      debugPrint("Caste ID: ${caste.id}");
    });
    update();
    debugPrint("Requested Caste ID: $casteId");
    debugPrint(
        "AuthController : ${authController.casteResponse.castes.toList()}");
    final matchingCaste = authController.casteResponse.castes.firstWhere(
      (caste) => caste.id == casteId,
      orElse: () {
        debugPrint(
            "Requested ID: $casteId not found. Printing all castes again:");
        authController.casteResponse.castes.forEach((caste) {
          debugPrint("Caste ID: ${caste.id} and Requested ID: $casteId");
        });
        return Caste(id: 0, name: 'Unknown', religionId: 0);
      },
    );

    caste = matchingCaste.name;
    debugPrint("Selected Caste: $caste");
    update();
  }

  void setCountry(int id) {
    final matchingCountry = authController.countryResponse.countries.firstWhere(
      (country) => country.id == id,
      orElse: () => Country(id: 0, name: 'Unknown'),
    );
    country = matchingCountry.name;
    debugPrint("Country: $country");
    update();
  }

  Future<void> setState({required int stateId, required int countryId}) async {
    await authController.getStates(countryId.toString());
    debugPrint("States: ${authController.stateResponse.states.toList()}");
    debugPrint("Requested State ID: $stateId");
    final matchingState = authController.stateResponse.states.firstWhere(
      (state) => state.id == stateId,
      orElse: () => StateModel(id: 0, name: 'Unknown', countryId: 0),
    );
    state = matchingState.name;
    debugPrint("State: $state");
    update();
  }

  void setGender(int id) {
    final matchingGender = authController.dataModel.genders.firstWhere(
      (gender) => gender.id == id,
      orElse: () => Gender(id: 0, gender: 'Unknown'),
    );
    gender = matchingGender.gender;
  }

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

  void updateState(String? value) {
    state = value;
    update();
  }

  void updateCountry(String value) {
    country = value;
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

  Future<void> updatePersonalDetails() async {
    if (lookingFor == null) {
      Get.snackbar(
        "Error",
        "Looking for cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (maritalStatus == null) {
      Get.snackbar(
        "Error",
        "Marital status cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (firstNameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "First name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (lastNameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Last name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (religion == null || religion!.isEmpty) {
      Get.snackbar(
        "Error",
        "Religion cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (country == null || country!.isEmpty) {
      Get.snackbar(
        "Error",
        "Country cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (state == null || state!.isEmpty) {
      Get.snackbar(
        "Error",
        "State cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (dobController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Date of birth cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (gender == null) {
      Get.snackbar(
        "Error",
        "Gender cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Map<String, dynamic> data = {
      "looking_for": authController.lookingForList
          .firstWhere((item) => item.title == lookingFor,
              orElse: () => LookingFor(id: 0, title: 'Unknown'))
          .id,
      "marital_status": authController.dataModel.maritalStatuses
          .firstWhere((item) => item.title == maritalStatus,
              orElse: () => MaritalStatus(id: 0, title: 'Unknown'))
          .id,
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "religions": authController.religionResponse.religions
          .firstWhere((item) => item.name == religion,
              orElse: () => Religion(
                  id: 0, name: 'Unknown', createdAt: '', updatedAt: ''))
          .id,
      "caste": authController.casteResponse.castes
          .firstWhere((item) => item.name == caste,
              orElse: () => Caste(id: 0, name: 'Unknown', religionId: 0))
          .id,
      "state": authController.stateResponse.states
          .firstWhere((item) => item.name == state,
              orElse: () => StateModel(id: 0, name: 'Unknown', countryId: 0))
          .id,
      "birthDate": dobController.text,
      "country": authController.countryResponse.countries
          .firstWhere((item) => item.name == country,
              orElse: () => Country(id: 0, name: 'Unknown'))
          .id,
      "gender": authController.dataModel.genders
          .firstWhere((item) => item.gender == gender,
              orElse: () => Gender(id: 0, gender: 'Unknown'))
          .id,
    };

    try {
      showLoading();
      await profileRepo.updateProfileDetails(
          data: data, type: "personalDetails");
      fetchProfile();
      hideLoading();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update personal details: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      hideLoading();
    }
  }

  //Family Background

  TextEditingController fathersNameController = TextEditingController();
  TextEditingController fathersProfessionController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherProfessionController = TextEditingController();
  TextEditingController numberOfSiblingsController = TextEditingController();

  void setFamilyBackground() {
    isLoading.value = true;
    fathersNameController.text =
        profile.value?.data?.user?.fatherName ?? "Not Available";
    fathersProfessionController.text =
        profile.value?.data?.user?.fatherProfession ?? "Not Available";
    motherNameController.text =
        profile.value?.data?.user?.motherName ?? "Not Available";
    motherProfessionController.text =
        profile.value?.data?.user?.motherProfession ?? "Not Available";
    numberOfSiblingsController.text =
        profile.value?.data?.user?.numberOfSiblings.toString() ?? "0";

    isLoading.value = false;
  }

  Future<void> updateFamilyDetails() async {
    if (fathersNameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Father's name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (fathersProfessionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Father's profession cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (motherNameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Mother's name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (motherProfessionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Mother's profession cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (numberOfSiblingsController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Number of siblings cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    int? numberOfSiblings = int.tryParse(numberOfSiblingsController.text);
    if (numberOfSiblings == null || numberOfSiblings < 0) {
      Get.snackbar(
        "Error",
        "Number of siblings must be a valid non-negative number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Map<String, dynamic> data = {
      "father_name": fathersNameController.text,
      "father_profession": fathersProfessionController.text,
      "mother_name": motherNameController.text,
      "mother_profession": motherProfessionController.text,
      "number_of_siblings": numberOfSiblings,
    };
    try {
      showLoading();
      await profileRepo.updateProfileDetails(data: data, type: "family");
      fetchProfile();
      hideLoading();
    } catch (e) {
      hideLoading();
      Get.snackbar(
        "Error",
        "Failed to update family details: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      hideLoading();
    }
  }

//Education & Profession Details

  String? highestQualification;
  String? degree;
  TextEditingController schoolUniversityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDayController = TextEditingController();
  TextEditingController companyOrganisationController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController monthlyIncomeController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  int? experience = 0;
  String? noOfYears;

  void setEducationProfesionDetails() {
    isLoading.value = true;

    setHighestQualification(int.parse(profile
            .value?.data?.user?.educationInfoData?.first.highestQualification ??
        '1'));
    setDegree(int.parse(
        profile.value?.data?.user?.educationInfoData?.first.degree ?? '1'));
    schoolUniversityController.text =
        profile.value?.data?.user?.educationInfoData?.first.institute ?? "";

    if (profile.value?.data?.user?.educationInfoData?.first.startingYear !=
        null) {
      String startingYear = profile
          .value!.data!.user!.educationInfoData!.first.startingYear!
          .toString();
      startDateController.text =
          DateConverter.formatDate(DateTime.parse(startingYear));
      selectedStartDate = DateTime.parse(startingYear);
    } else {
      startDateController.text = "";
      selectedStartDate = null;
    }

    if (profile.value?.data?.user?.educationInfoData?.first.endingYear !=
        null) {
      String endingYear = profile
          .value!.data!.user!.educationInfoData!.first.endingYear!
          .toString();
      endDayController.text =
          DateConverter.formatDate(DateTime.parse(endingYear));
      selectedEndDate = DateTime.parse(endingYear);
    } else {
      endDayController.text = "";
      selectedEndDate = null;
    }

    companyOrganisationController.text =
        profile.value?.data?.user?.careerInfo?.first.company ?? "";
    designationController.text =
        profile.value?.data?.user?.careerInfo?.first.designation ?? "";
    monthlyIncomeController.text =
        profile.value?.data?.user?.careerInfo?.first.monthlyIncome ?? "0";
    experience = profile.value?.data?.user?.careerInfo?.first.experience ?? 0;
    noOfYears = experience.toString();

    isLoading.value = false;
  }

  void setHighestQualification(int id) {
    final matchingQualification =
        authController.dataModel.qualifications.firstWhere(
      (qualification) => qualification.id == id,
      orElse: () => Qualification(id: 0, name: 'Unknown'),
    );
    highestQualification = matchingQualification.name;
  }

  void setDegree(int id) {
    final matchingDegree = authController.degreeResponse.Degrees.firstWhere(
      (status) => status.id == id,
      orElse: () => Degree(id: 0, name: 'Unknown'),
    );
    degree = matchingDegree.name;
  }

  void updateHighestQualification(String value) {
    highestQualification = value;
    update();
  }

  void updateDegree(String? value) {
    degree = value;
    update();
  }

  void updateExperience(int i) {
    experience = i;
    noOfYears = experience.toString();
    update();
  }

  Future<void> updateEducationalDetails() async {
    if (highestQualification == null || highestQualification!.isEmpty) {
      Get.snackbar(
        "Error",
        "Highest qualification cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (schoolUniversityController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Institute name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (startDateController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Starting year cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (endDayController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Ending year cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (companyOrganisationController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Company/Organization name cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (designationController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Designation cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (monthlyIncomeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Monthly income cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (noOfYears == null ||
        noOfYears!.isEmpty ||
        int.tryParse(noOfYears!) == null) {
      Get.snackbar(
        "Error",
        "Experience must be a valid number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (highestQualification != "High School" &&
        highestQualification != "Intermediate") {
      if ((degree == null || degree!.isEmpty)) {
        Get.snackbar(
          "Error",
          "Degree cannot be empty.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        return;
      }
    }

    int? qualificationId = authController.dataModel.qualifications
        .firstWhere(
          (qualification) => qualification.name == highestQualification,
          orElse: () => Qualification(id: 0, name: 'Unknown'),
        )
        .id;

    int? degreeId = authController.degreeResponse.Degrees
        .firstWhere(
          (degreeItem) => degreeItem.name == degree,
          orElse: () => Degree(id: 0, name: 'Unknown'),
        )
        .id;

    if (qualificationId == 0) {
      Get.snackbar(
        "Error",
        "Invalid highest qualification selected.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Map<String, dynamic> data = {
      "highest_qualification": qualificationId,
      "institute": schoolUniversityController.text,
      "starting_year": startDateController.text,
      "ending_year": endDayController.text,
      "company": companyOrganisationController.text,
      "designation": designationController.text,
      "monthly_income": monthlyIncomeController.text,
      "experience": noOfYears,
      if (degreeId != 0) "degree": degreeId
    };

    try {
      showLoading();
      await profileRepo.updateProfileDetails(data: data, type: "educational");
      fetchProfile();
      hideLoading();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update educational details: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      hideLoading();
    }
  }

  //Personality Details
  String? complexion;
  String? bloodGroup;
  String? smokingHabit;
  String? disability;
  String? drinkingHabit;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController hairController = TextEditingController();
  TextEditingController eyeColorController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController interestController = TextEditingController();

  void setPersonalityDetails() {
    isLoading.value = true;
    heightController.text =
        profile.value?.data?.user?.physicalAttributes?.height.toString() ?? "0";
    weightController.text =
        profile.value?.data?.user?.physicalAttributes?.weight.toString() ?? "0";
    hairController.text =
        profile.value?.data?.user?.physicalAttributes?.hairColor ?? "";
    eyeColorController.text =
        profile.value?.data?.user?.physicalAttributes?.eyeColor ?? "";
    bioController.text =
        profile.value?.data?.user?.physicalAttributes?.bio ?? "";
    interestController.text =
        profile.value?.data?.user?.physicalAttributes?.interestsHobbies ?? "";
    setComplexion(
        profile.value?.data?.user?.physicalAttributes?.complexion ?? 1);
    setBloodGroup(
        profile.value?.data?.user?.physicalAttributes?.bloodGroup ?? 1);
    setSmokingHabit(int.parse(profile
            .value?.data?.user?.physicalAttributes?.smokingHabit
            .toString() ??
        '1'));
    setDrinkingHabit(int.parse(profile
            .value?.data?.user?.physicalAttributes?.drinkingHabit
            .toString() ??
        '1'));
    setDisability(
        profile.value?.data?.user?.physicalAttributes?.disabilities ?? 1);

    isLoading.value = false;
  }

  void setComplexion(int id) {
    final matchingComplexion = authController.dataModel.complexion.firstWhere(
      (complexion) => complexion.id == id,
      orElse: () => Complexion(id: 1, name: 'Unknown'),
    );
    complexion = matchingComplexion.name;
  }

  void setBloodGroup(int id) {
    final matchingBloodGroup = authController.dataModel.bloodGroups.firstWhere(
      (bloodGroup) => bloodGroup.id == id,
      orElse: () => BloodGroup(id: 1, name: 'Unknown'),
    );
    bloodGroup = matchingBloodGroup.name;
  }

  void setSmokingHabit(int id) {
    final matchingSmokingHabit = authController.dataModel.smoking.firstWhere(
      (smokingHabit) => smokingHabit.id == id,
      orElse: () => Smoking(id: 1, name: 'Unknown'),
    );
    smokingHabit = matchingSmokingHabit.name;
  }

  void setDrinkingHabit(int id) {
    final matchingDrinkingHabit = authController.dataModel.drinking.firstWhere(
      (drinkingHabit) => drinkingHabit.id == id,
      orElse: () => Drinking(id: 1, name: 'Unknown'),
    );
    drinkingHabit = matchingDrinkingHabit.name;
  }

  void setDisability(int id) {
    final matchingDisability = authController.dataModel.disabilities.firstWhere(
      (disability) => disability.id == id,
      orElse: () => Disability(id: 1, name: 'Unknown'),
    );
    disability = matchingDisability.name;
  }

  void updateComplexion(String value) {
    complexion = value;
    update();
  }

  void updateBloodGroup(String value) {
    bloodGroup = value;
    update();
  }

  void updateSmokingHabit(String value) {
    smokingHabit = value;
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

  Future<void> updatePhysicalAttributes() async {
    if (heightController.text.isEmpty ||
        int.tryParse(heightController.text) == null) {
      Get.snackbar(
        "Error",
        "Height must be a valid number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (weightController.text.isEmpty ||
        int.tryParse(weightController.text) == null) {
      Get.snackbar(
        "Error",
        "Weight must be a valid number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (bloodGroup == null || bloodGroup!.isEmpty) {
      Get.snackbar(
        "Error",
        "Blood group cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (eyeColorController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Eye color cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (hairController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Hair color cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (complexion == null || complexion!.isEmpty) {
      Get.snackbar(
        "Error",
        "Complexion cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (smokingHabit == null || smokingHabit!.isEmpty) {
      Get.snackbar(
        "Error",
        "Smoking habit cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (drinkingHabit == null || drinkingHabit!.isEmpty) {
      Get.snackbar(
        "Error",
        "Drinking habit cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (bioController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Bio cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (interestController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Interests and hobbies cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Map<String, dynamic> data = {
      "height": int.parse(heightController.text),
      "weight": int.parse(weightController.text),
      "blood_group": authController.dataModel.bloodGroups
          .firstWhere((item) => item.name == bloodGroup,
              orElse: () => BloodGroup(id: 0, name: 'Unknown'))
          .id,
      "eye_color": eyeColorController.text,
      "hair_color": hairController.text,
      "complexion": authController.dataModel.complexion
          .firstWhere((item) => item.name == complexion,
              orElse: () => Complexion(id: 0, name: 'Unknown'))
          .id,
      "disabilities": authController.dataModel.disabilities
          .firstWhere((item) => item.name == disability,
              orElse: () => Disability(id: 0, name: 'Unknown'))
          .id,
      "smoking_habit": authController.dataModel.smoking
          .firstWhere((item) => item.name == smokingHabit,
              orElse: () => Smoking(id: 0, name: 'Unknown'))
          .id,
      "drinking_habit": authController.dataModel.drinking
          .firstWhere((item) => item.name == drinkingHabit,
              orElse: () => Drinking(id: 0, name: 'Unknown'))
          .id,
      "bio": bioController.text,
      "interests_hobbies": interestController.text,
    };

    try {
      showLoading();
      await profileRepo.updateProfileDetails(
          data: data, type: "physicalAttributeInfo");
      fetchProfile();
      hideLoading();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update physical attributes: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      hideLoading();
    }
  }

  //Preference Details

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

  Future<void> setPreferenceDetails() async {
    isLoading.value = true;

    prefAgeController.text =
        profile.value?.data?.user?.partnerExpectation?.age.toString() ?? "0";
    prefHeightController.text =
        profile.value?.data?.user?.partnerExpectation?.height.toString() ?? "0";
    setPrefSmokingHabit(
        profile.value?.data?.user?.partnerExpectation?.smokingStatus ?? 1);
    setPrefDrinkingHabit(
        profile.value?.data?.user?.partnerExpectation?.drinkingStatus ?? 1);
    await setPrefReligion(
        profile.value?.data?.user?.partnerExpectation?.religion);
    await setPrefCountry(
        profile.value?.data?.user?.partnerExpectation?.country);
    setPrefQualification(
        profile.value?.data?.user?.partnerExpectation?.qualifications);
    setPrefComplexion(
        profile.value?.data?.user?.partnerExpectation?.complexions);

    isLoading.value = false;
  }

  Future<void> setPrefState(List<String> value) async {
    if (value.isEmpty) {
      prefState = [];
      update();
      return;
    }

    debugPrint(
        "Values passed State: ${value.map((id) => id.toString()).toList()}");
    debugPrint("Values passed State: $value");

    await authController.getStatesList(value);
    List<int>? selectedStateIds =
        profile.value?.data?.user?.partnerExpectation?.state;

    if (selectedStateIds == null || selectedStateIds.isEmpty) {
      prefState = [];
      update();
      return;
    }

    List<String> matchingStates = selectedStateIds.map((id) {
      final state = authController.stateResponse.states.firstWhere(
        (status) => status.id == id,
        orElse: () => StateModel(id: 0, name: 'Unknown', countryId: 0),
      );
      return state.name;
    }).toList();

    prefState = matchingStates;
    update();
  }

  Future<void> setPrefCountry(List<int>? value) async {
    if (value == null || value.isEmpty) {
      prefCountry = [];
      update();
      return;
    }
    List<String> matchingCountries = [];
    List<int> countryIdsForStates = [];

    value.forEach((id) {
      final country = authController.countryResponse.countries.firstWhere(
        (status) => status.id == id,
        orElse: () => Country(id: 0, name: 'Unknown'),
      );

      if (country.id != 0) {
        matchingCountries.add(country.name);
        countryIdsForStates.add(country.id);
      }
    });

    prefCountry = matchingCountries;
    update();

    await setPrefState(countryIdsForStates.map((id) => id.toString()).toList());
  }

  void setPrefQualification(List<int>? value) {
    if (value == null || value.isEmpty) {
      prefHighestQualification = [];
      update();
      return;
    }
    List<String> matchingQualifications = value.map((id) {
      final qualification = authController.dataModel.qualifications.firstWhere(
        (status) => status.id == id,
        orElse: () => Qualification(id: 0, name: 'Unknown'),
      );
      return qualification.name;
    }).toList();

    prefHighestQualification = matchingQualifications;
    update();
  }

  void setPrefComplexion(List<int>? value) {
    if (value == null || value.isEmpty) {
      prefComplexion = [];
      update();
      return;
    }
    List<String> matchingComplexion = value.map((id) {
      final complexion = authController.dataModel.complexion.firstWhere(
        (status) => status.id == id,
        orElse: () => Complexion(id: 0, name: 'Unknown'),
      );
      return complexion.name;
    }).toList();

    prefComplexion = matchingComplexion;
    update();
  }

  void setPrefSmokingHabit(int id) {
    final matchingSmokingHabit = authController.dataModel.smoking.firstWhere(
      (smokingHabit) => smokingHabit.id == id,
      orElse: () => Smoking(id: 1, name: ''),
    );
    prefSmokingHabit = matchingSmokingHabit.name;
    update();
  }

  void setPrefDrinkingHabit(int id) {
    final matchingDrinkingHabit = authController.dataModel.drinking.firstWhere(
      (drinkingHabit) => drinkingHabit.id == id,
      orElse: () => Drinking(id: 1, name: ''),
    );
    prefDrinkingHabit = matchingDrinkingHabit.name;
    update();
  }

  Future<void> setPrefReligion(List<int>? value) async {
    if (value == null || value.isEmpty) {
      prefReligion = [];
      update();
      return;
    }
    List<String> matchingReligions = value.map((id) {
      final religion = authController.religionResponse.religions.firstWhere(
        (status) => status.id == id,
        orElse: () =>
            Religion(id: 0, name: 'Unknown', createdAt: '', updatedAt: ''),
      );
      return religion.name;
    }).toList();

    prefReligion = matchingReligions;
    update();
    await setPrefCaste(value);
    debugPrint("Pref Religion: $prefReligion");
    debugPrint("Pref Religion IDs: $value");
  }

  Future<void> setPrefCaste(List<int>? value) async {
    debugPrint("Pref Religion IDs in Caste: $value");

    if (value == null || value.isEmpty) {
      prefCaste = [];
      update();
      return;
    }

    debugPrint("Values passed : ${value.map((id) => id.toString()).toList()}");

    await authController.getCasteList(
      value.map((id) => id.toString()).toList(),
    );

    List<int>? selectedCasteIds =
        profile.value?.data?.user?.partnerExpectation?.caste;
    debugPrint("Selected Caste IDs: $selectedCasteIds");
    debugPrint("Caste Response: ${authController.casteResponse.castes}");

    if (selectedCasteIds == null || selectedCasteIds.isEmpty) {
      prefCaste = [];
      update();
      return;
    }

    List<String> matchingCaste = selectedCasteIds.map((id) {
      final caste = authController.casteListResponse.castes.firstWhere(
        (status) => status.id == id,
        orElse: () => Caste(id: 0, name: 'Unknown', religionId: 0),
      );
      return caste.name;
    }).toList();

    prefCaste = matchingCaste;
    update();
    debugPrint("Pref Castes: $prefCaste");
  }

  void updatePrefReligion(List<String> value) {
    prefReligion = value;
    update();
  }

  void updatePrefCasteList(List<String> value) {
    prefCaste = value;
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

  void updatePrefComplexion(List<String> value) {
    prefComplexion = value;
    update();
  }

  void updatePrefCountryList(List<String> value) {
    prefCountry = value;
    update();
  }

  void updatePrefStateList(List<String> value) {
    prefState = value;
    update();
  }

  void updatePrefQualification(List<String> value) {
    prefHighestQualification = value;
    update();
  }

  Future<void> updatePreferenceDetails() async {
    if (prefAgeController.text.isEmpty ||
        int.tryParse(prefAgeController.text) == null) {
      Get.snackbar(
        "Error",
        "Age must be a valid number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefHeightController.text.isEmpty ||
        int.tryParse(prefHeightController.text) == null) {
      Get.snackbar(
        "Error",
        "Height must be a valid number.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefReligion == null || prefReligion!.isEmpty) {
      Get.snackbar(
        "Error",
        "Religion cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefCaste == null || prefCaste!.isEmpty) {
      Get.snackbar(
        "Error",
        "Caste cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefCountry == null || prefCountry!.isEmpty) {
      Get.snackbar(
        "Error",
        "Country cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefState == null || prefState!.isEmpty) {
      Get.snackbar(
        "Error",
        "State cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    if (prefComplexion == null || prefComplexion!.isEmpty) {
      Get.snackbar(
        "Error",
        "Complexion cannot be empty.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Map<String, dynamic> data = {
      "age": int.parse(prefAgeController.text),
      "height": int.parse(prefHeightController.text),
      "religion": authController.religionResponse.religions
          .where((item) => prefReligion?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
      "caste": authController.casteListResponse.castes
          .where((item) => prefCaste?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
      "complexions": authController.dataModel.complexion
          .where((item) => prefComplexion?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
      "country": authController.countryResponse.countries
          .where((item) => prefCountry?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
      "state": authController.stateResponse.states
          .where((item) => prefState?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
      "smoking_status": authController.dataModel.smoking
          .firstWhere((item) => item.name == prefSmokingHabit,
              orElse: () => Smoking(id: 0, name: 'Unknown'))
          .id,
      "drinking_status": authController.dataModel.drinking
          .firstWhere((item) => item.name == prefDrinkingHabit,
              orElse: () => Drinking(id: 0, name: 'Unknown'))
          .id,
      "qualifications": authController.dataModel.qualifications
          .where(
              (item) => prefHighestQualification?.contains(item.name) ?? false)
          .map((item) => item.id)
          .toList(),
    };

    try {
      showLoading();
      await profileRepo.updateProfileDetails(data: data, type: "preferences");
      fetchProfile();
      hideLoading();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update physical attributes: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      hideLoading();
    }
  }
}
