// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final int? profileId;
  final String? firstname;
  final String? lastname;
  final int? lookingFor;
  final String? username;
  final dynamic address;
  final String? email;
  final int? country;
  final String? mobile;
  final String? balance;
  final int? caste;
  final int? status;
  final dynamic kycData;
  final int? kv;
  final int? ev;
  final int? sv;
  final int? profileComplete;
  final List<dynamic>? skippedStep;
  final List<int>? completedStep;
  final int? totalStep;
  final dynamic verCodeSendAt;
  final dynamic tsc;
  final dynamic loginBy;
  final dynamic banReason;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bloodGroup;
  final int? religions;
  final int? maritalStatus;
  final dynamic motherTongue;
  final dynamic community;
  final int? gender;
  final dynamic profession;
  final dynamic middleName;
  final dynamic fun;
  final dynamic fitness;
  final dynamic otherInterest;
  final dynamic creative;
  final dynamic hobby;
  final String? diet;
  final dynamic interest;
  final dynamic deviceToken;
  final DateTime? birthDate;
  final String? profileImage;
  final String? fatherName;
  final String? fatherProfession;
  final String? motherName;
  final String? motherProfession;
  final int? numberOfSiblings;
  final int? state;
  final String? userVerify;
  final String? fcmToken;

  UserModel({
    this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.lookingFor,
    this.username,
    this.address,
    this.email,
    this.country,
    this.mobile,
    this.balance,
    this.caste,
    this.status,
    this.kycData,
    this.kv,
    this.ev,
    this.sv,
    this.profileComplete,
    this.skippedStep,
    this.completedStep,
    this.totalStep,
    this.verCodeSendAt,
    this.tsc,
    this.loginBy,
    this.banReason,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.bloodGroup,
    this.religions,
    this.maritalStatus,
    this.motherTongue,
    this.community,
    this.gender,
    this.profession,
    this.middleName,
    this.fun,
    this.fitness,
    this.otherInterest,
    this.creative,
    this.hobby,
    this.diet,
    this.interest,
    this.deviceToken,
    this.birthDate,
    this.profileImage,
    this.fatherName,
    this.fatherProfession,
    this.motherName,
    this.motherProfession,
    this.numberOfSiblings,
    this.state,
    this.userVerify,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        profileId: json["profile_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        lookingFor: json["looking_for"],
        username: json["username"],
        address: json["address"],
        email: json["email"],
        country: json["country"],
        mobile: json["mobile"],
        balance: json["balance"],
        caste: json["caste"],
        status: json["status"],
        kycData: json["kyc_data"],
        kv: json["kv"],
        ev: json["ev"],
        sv: json["sv"],
        profileComplete: json["profile_complete"],
        skippedStep: json["skipped_step"] == null
            ? []
            : List<dynamic>.from(json["skipped_step"]!.map((x) => x)),
        completedStep: json["completed_step"] == null
            ? []
            : List<int>.from(json["completed_step"]!.map((x) => x)),
        totalStep: json["total_step"],
        verCodeSendAt: json["ver_code_send_at"],
        tsc: json["tsc"],
        loginBy: json["login_by"],
        banReason: json["ban_reason"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bloodGroup: json["blood_group"],
        religions: json["religions"],
        maritalStatus: json["marital_status"],
        motherTongue: json["mother_tongue"],
        community: json["community"],
        gender: json["gender"],
        profession: json["profession"],
        middleName: json["middle_name"],
        fun: json["fun"],
        fitness: json["fitness"],
        otherInterest: json["other_interest"],
        creative: json["creative"],
        hobby: json["hobby"],
        diet: json["diet"],
        interest: json["interest"],
        deviceToken: json["device_token"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        profileImage: json["profile_image"],
        fatherName: json["father_name"],
        fatherProfession: json["father_profession"],
        motherName: json["mother_name"],
        motherProfession: json["mother_profession"],
        numberOfSiblings: json["number_of_siblings"],
        state: json["state"],
        userVerify: json["user_verify"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_id": profileId,
        "firstname": firstname,
        "lastname": lastname,
        "looking_for": lookingFor,
        "username": username,
        "address": address,
        "email": email,
        "country": country,
        "mobile": mobile,
        "balance": balance,
        "caste": caste,
        "status": status,
        "kyc_data": kycData,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "skipped_step": skippedStep == null
            ? []
            : List<dynamic>.from(skippedStep!.map((x) => x)),
        "completed_step": completedStep == null
            ? []
            : List<dynamic>.from(completedStep!.map((x) => x)),
        "total_step": totalStep,
        "ver_code_send_at": verCodeSendAt,
        "tsc": tsc,
        "login_by": loginBy,
        "ban_reason": banReason,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "blood_group": bloodGroup,
        "religions": religions,
        "marital_status": maritalStatus,
        "mother_tongue": motherTongue,
        "community": community,
        "gender": gender,
        "profession": profession,
        "middle_name": middleName,
        "fun": fun,
        "fitness": fitness,
        "other_interest": otherInterest,
        "creative": creative,
        "hobby": hobby,
        "diet": diet,
        "interest": interest,
        "device_token": deviceToken,
        "birth_date": birthDate?.toIso8601String(),
        "profile_image": profileImage,
        "father_name": fatherName,
        "father_profession": fatherProfession,
        "mother_name": motherName,
        "mother_profession": motherProfession,
        "number_of_siblings": numberOfSiblings,
        "state": state,
        "user_verify": userVerify,
        "fcmToken": fcmToken,
      };
}
