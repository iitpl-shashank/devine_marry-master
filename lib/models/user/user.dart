import 'dart:convert';

class UserModel {
  final int id;
  final int? profileId;
  final String? firstname;
  final String? lastname;
  final String? lookingFor;
  final String? country;
  final String? caste;
  final String mobile;
  final int status;
  final int kv;
  final int? profileComplete;
  final int? completedStep;
  final int? totalStep;
  final String? banReason;
  final String? image;
  final String? rememberToken;
  final String? bloodGroup;
  final String? religions;
  final String? gender;
  final String? diet;
  final String? deviceToken;
  final String? birthDate;
  final String? fatherName;
  final String? fatherProfession;
  final String? motherName;
  final String? motherProfession;
  final int? numberOfSiblings;
  final String? state;
  final String? fcmToken;

  UserModel({
    required this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.lookingFor,
    this.country,
    this.caste,
    required this.mobile,
    required this.status,
    required this.kv,
    this.profileComplete,
    this.completedStep,
    this.totalStep,
    this.banReason,
    this.image,
    this.rememberToken,
    this.bloodGroup,
    this.religions,
    this.gender,
    this.diet,
    this.deviceToken,
    this.birthDate,
    this.fatherName,
    this.fatherProfession,
    this.motherName,
    this.motherProfession,
    this.numberOfSiblings,
    this.state,
    this.fcmToken,
  });

  /// ✅ **Dynamic JSON Parsing: Safe from Type Mismatch**
  factory UserModel.fromJson(Map<String, dynamic> json) {
    T? parseValue<T>(dynamic value, {T? defaultValue}) {
      if (value is T) return value; // Return if already correct type
      if (T == int) return int.tryParse(value?.toString() ?? '') as T? ?? defaultValue;
      if (T == String) return value?.toString() as T? ?? defaultValue;
      return defaultValue;
    }

    return UserModel(
      id: parseValue<int>(json['id'], defaultValue: 0)!,
      profileId: parseValue<int>(json['profile_id']),
      firstname: parseValue<String>(json['firstname']),
      lastname: parseValue<String>(json['lastname']),
      lookingFor: parseValue<String>(json['looking_for']),
      country: parseValue<String>(json['country']),
      caste: parseValue<String>(json['caste']),
      mobile: parseValue<String>(json['mobile'], defaultValue: "")!,
      status: parseValue<int>(json['status'], defaultValue: 0)!,
      kv: parseValue<int>(json['kv'], defaultValue: 0)!,
      profileComplete: parseValue<int>(json['profile_complete']),
      completedStep: parseValue<int>(json['completed_step']),
      totalStep: parseValue<int>(json['total_step']),
      banReason: parseValue<String>(json['ban_reason']),
      image: parseValue<String>(json['image']),
      rememberToken: parseValue<String>(json['remember_token']),
      bloodGroup: parseValue<String>(json['blood_group']),
      religions: parseValue<String>(json['religions']),
      gender: parseValue<String>(json['gender']),
      diet: parseValue<String>(json['diet']),
      deviceToken: parseValue<String>(json['device_token']),
      birthDate: parseValue<String>(json['birth_date']),
      fatherName: parseValue<String>(json['father_name']),
      fatherProfession: parseValue<String>(json['father_profession']),
      motherName: parseValue<String>(json['mother_name']),
      motherProfession: parseValue<String>(json['mother_profession']),
      numberOfSiblings: parseValue<int>(json['number_of_siblings']),
      state: parseValue<String>(json['state']),
      fcmToken: parseValue<String>(json['fcmToken']),
    );
  }

  /// ✅ Converts model back to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'firstname': firstname,
      'lastname': lastname,
      'looking_for': lookingFor,
      'country': country,
      'caste': caste,
      'mobile': mobile,
      'status': status,
      'kv': kv,
      'profile_complete': profileComplete,
      'completed_step': completedStep,
      'total_step': totalStep,
      'ban_reason': banReason,
      'image': image,
      'remember_token': rememberToken,
      'blood_group': bloodGroup,
      'religions': religions,
      'gender': gender,
      'diet': diet,
      'device_token': deviceToken,
      'birth_date': birthDate,
      'father_name': fatherName,
      'father_profession': fatherProfession,
      'mother_name': motherName,
      'mother_profession': motherProfession,
      'number_of_siblings': numberOfSiblings,
      'state': state,
      'fcmToken': fcmToken,
    };
  }
}