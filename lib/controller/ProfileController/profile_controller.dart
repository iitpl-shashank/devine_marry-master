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

  void setPersonalDetails() {
    isLoading.value = true;
    firstNameController.text = profile.value?.data?.user?.firstname ?? "";
    lastNameController.text = profile.value?.data?.user?.lastname ?? "";
    dobController.text = profile.value?.data?.user?.birthDate.toString() ?? "";
    setLookingFor(profile.value?.data?.user?.lookingFor ?? 1);
    setMaritalStatus(
        int.parse(profile.value?.data?.user?.maritalStatus ?? '1'));
    setReligion(int.parse(profile.value?.data?.user?.religions ?? '1'));
    setCaste(int.parse(profile.value?.data?.user?.caste ?? '1'));
    setCountry(profile.value?.data?.user?.country ?? 1);
    setState(profile.value?.data?.user?.state ?? 1);
    setGender(int.parse(profile.value?.data?.user?.gender ?? '1'));
    dob = dobController.text;

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
  }

  void setReligion(int id) {
    final matchingReligion =
        authController.religionResponse.religions.firstWhere(
      (status) => status.id == id,
      orElse: () =>
          Religion(id: 0, name: 'Unknown', createdAt: '', updatedAt: ''),
    );
    religion = matchingReligion.name;
    authController.getCastes(id.toString());
  }

  void setCaste(int id) {
    final matchingCaste = authController.casteResponse.castes.firstWhere(
      (caste) => caste.id == id,
      orElse: () => Caste(id: 0, name: 'Unknown'),
    );
    caste = matchingCaste.name;
    debugPrint("Caste: $caste");
  }

  void setCountry(int id) {
    final matchingCountry = authController.countryResponse.countries.firstWhere(
      (country) => country.id == id,
      orElse: () => Country(id: 0, name: 'Unknown'),
    );
    country = matchingCountry.name;
    authController.getStates(id.toString());
  }

  void setState(int id) {
    debugPrint("States: ${authController.stateResponse.states}");
    final matchingState = authController.stateResponse.states.firstWhere(
      (state) => state.id == id,
      orElse: () => StateModel(id: 0, name: 'Unknown'),
    );
    state = matchingState.name;
    debugPrint("State: $state");
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
        profile.value?.data?.user?.educationInfoData?.first.institute ??
            "Not Available";

    if (profile.value?.data?.user?.educationInfoData?.first.startingYear !=
        null) {
      String startingYear = profile
          .value!.data!.user!.educationInfoData!.first.startingYear!
          .toString();
      startDateController.text =
          DateConverter.formatDate(DateTime.parse(startingYear));
      selectedStartDate = DateTime.parse(startingYear);
    } else {
      startDateController.text = "Not Available";
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
      endDayController.text = "Not Available";
      selectedEndDate = null;
    }

    companyOrganisationController.text =
        profile.value?.data?.user?.careerInfo?.first.company ?? "Not Available";
    designationController.text =
        profile.value?.data?.user?.careerInfo?.first.designation ??
            "Not Available";
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
}
