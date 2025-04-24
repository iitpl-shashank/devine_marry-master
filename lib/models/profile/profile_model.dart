// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    final bool? status;
    final String? message;
    final Data? data;

    ProfileModel({
        this.status,
        this.message,
        this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final User? user;

    Data({
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}

class User {
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
    final int? connectCount;
    final int? matchesCount;
    final String? imageUrl;
    final PhysicalAttributes? physicalAttributes;
    final List<EducationInfoDatum>? educationInfoData;
    final List<CareerInfo>? careerInfo;
    final PartnerExpectation? partnerExpectation;

    User({
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
        this.connectCount,
        this.matchesCount,
        this.imageUrl,
        this.physicalAttributes,
        this.educationInfoData,
        this.careerInfo,
        this.partnerExpectation,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        skippedStep: json["skipped_step"] == null ? [] : List<dynamic>.from(json["skipped_step"]!.map((x) => x)),
        completedStep: json["completed_step"] == null ? [] : List<int>.from(json["completed_step"]!.map((x) => x)),
        totalStep: json["total_step"],
        verCodeSendAt: json["ver_code_send_at"],
        tsc: json["tsc"],
        loginBy: json["login_by"],
        banReason: json["ban_reason"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        profileImage: json["profile_image"],
        fatherName: json["father_name"],
        fatherProfession: json["father_profession"],
        motherName: json["mother_name"],
        motherProfession: json["mother_profession"],
        numberOfSiblings: json["number_of_siblings"],
        state: json["state"],
        userVerify: json["user_verify"],
        fcmToken: json["fcmToken"],
        connectCount: json["connect_count"],
        matchesCount: json["matches_count"],
        imageUrl: json["image_url"],
        physicalAttributes: json["physical_attributes"] == null ? null : PhysicalAttributes.fromJson(json["physical_attributes"]),
        educationInfoData: json["education_info_data"] == null ? [] : List<EducationInfoDatum>.from(json["education_info_data"]!.map((x) => EducationInfoDatum.fromJson(x))),
        careerInfo: json["career_info"] == null ? [] : List<CareerInfo>.from(json["career_info"]!.map((x) => CareerInfo.fromJson(x))),
        partnerExpectation: json["partner_expectation"] == null ? null : PartnerExpectation.fromJson(json["partner_expectation"]),
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
        "skipped_step": skippedStep == null ? [] : List<dynamic>.from(skippedStep!.map((x) => x)),
        "completed_step": completedStep == null ? [] : List<dynamic>.from(completedStep!.map((x) => x)),
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
        "connect_count": connectCount,
        "matches_count": matchesCount,
        "image_url": imageUrl,
        "physical_attributes": physicalAttributes?.toJson(),
        "education_info_data": educationInfoData == null ? [] : List<dynamic>.from(educationInfoData!.map((x) => x.toJson())),
        "career_info": careerInfo == null ? [] : List<dynamic>.from(careerInfo!.map((x) => x.toJson())),
        "partner_expectation": partnerExpectation?.toJson(),
    };
}

class CareerInfo {
    final int? id;
    final int? userId;
    final String? company;
    final String? designation;
    final String? monthlyIncome;
    final int? experience;
    final dynamic end;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic start;

    CareerInfo({
        this.id,
        this.userId,
        this.company,
        this.designation,
        this.monthlyIncome,
        this.experience,
        this.end,
        this.createdAt,
        this.updatedAt,
        this.start,
    });

    factory CareerInfo.fromJson(Map<String, dynamic> json) => CareerInfo(
        id: json["id"],
        userId: json["user_id"],
        company: json["company"],
        designation: json["designation"],
        monthlyIncome: json["monthly_income"],
        experience: json["experience"],
        end: json["end"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        start: json["start"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company": company,
        "designation": designation,
        "monthly_income": monthlyIncome,
        "experience": experience,
        "end": end,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "start": start,
    };
}

class EducationInfoDatum {
    final int? id;
    final int? userId;
    final String? highestQualification;
    final String? degree;
    final dynamic fieldOfInterest;
    final String? institute;
    final int? regNo;
    final int? rollNo;
    final String? outOf;
    final String? result;
    final DateTime? startingYear;
    final DateTime? endingYear;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    EducationInfoDatum({
        this.id,
        this.userId,
        this.highestQualification,
        this.degree,
        this.fieldOfInterest,
        this.institute,
        this.regNo,
        this.rollNo,
        this.outOf,
        this.result,
        this.startingYear,
        this.endingYear,
        this.createdAt,
        this.updatedAt,
    });

    factory EducationInfoDatum.fromJson(Map<String, dynamic> json) => EducationInfoDatum(
        id: json["id"],
        userId: json["user_id"],
        highestQualification: json["highest_qualification"],
        degree: json["degree"],
        fieldOfInterest: json["field_of_interest"],
        institute: json["institute"],
        regNo: json["reg_no"],
        rollNo: json["roll_no"],
        outOf: json["out_of"],
        result: json["result"],
        startingYear: json["starting_year"] == null ? null : DateTime.parse(json["starting_year"]),
        endingYear: json["ending_year"] == null ? null : DateTime.parse(json["ending_year"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "highest_qualification": highestQualification,
        "degree": degree,
        "field_of_interest": fieldOfInterest,
        "institute": institute,
        "reg_no": regNo,
        "roll_no": rollNo,
        "out_of": outOf,
        "result": result,
        "starting_year": "${startingYear!.year.toString().padLeft(4, '0')}-${startingYear!.month.toString().padLeft(2, '0')}-${startingYear!.day.toString().padLeft(2, '0')}",
        "ending_year": "${endingYear!.year.toString().padLeft(4, '0')}-${endingYear!.month.toString().padLeft(2, '0')}-${endingYear!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class PartnerExpectation {
    final int? id;
    final int? userId;
    final int? age;
    final int? height;
    final List<int>? religion;
    final int? smokingStatus;
    final int? drinkingStatus;
    final List<int>? caste;
    final List<int>? country;
    final List<int>? state;
    final List<int>? qualifications;
    final List<int>? complexions;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    PartnerExpectation({
        this.id,
        this.userId,
        this.age,
        this.height,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.caste,
        this.country,
        this.state,
        this.qualifications,
        this.complexions,
        this.createdAt,
        this.updatedAt,
    });

    factory PartnerExpectation.fromJson(Map<String, dynamic> json) => PartnerExpectation(
        id: json["id"],
        userId: json["user_id"],
        age: json["age"],
        height: json["height"],
        religion: json["religion"] == null ? [] : List<int>.from(json["religion"]!.map((x) => x)),
        smokingStatus: json["smoking_status"],
        drinkingStatus: json["drinking_status"],
        caste: json["caste"] == null ? [] : List<int>.from(json["caste"]!.map((x) => x)),
        country: json["country"] == null ? [] : List<int>.from(json["country"]!.map((x) => x)),
        state: json["state"] == null ? [] : List<int>.from(json["state"]!.map((x) => x)),
        qualifications: json["qualifications"] == null ? [] : List<int>.from(json["qualifications"]!.map((x) => x)),
        complexions: json["complexions"] == null ? [] : List<int>.from(json["complexions"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "age": age,
        "height": height,
        "religion": religion == null ? [] : List<dynamic>.from(religion!.map((x) => x)),
        "smoking_status": smokingStatus,
        "drinking_status": drinkingStatus,
        "caste": caste == null ? [] : List<dynamic>.from(caste!.map((x) => x)),
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x)),
        "state": state == null ? [] : List<dynamic>.from(state!.map((x) => x)),
        "qualifications": qualifications == null ? [] : List<dynamic>.from(qualifications!.map((x) => x)),
        "complexions": complexions == null ? [] : List<dynamic>.from(complexions!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class PhysicalAttributes {
    final int? id;
    final int? userId;
    final int? height;
    final int? weight;
    final int? bloodGroup;
    final String? eyeColor;
    final String? hairColor;
    final int? complexion;
    final int? disabilities;
    final int? drinkingHabit;
    final int? smokingHabit;
    final String? bio;
    final String? interestsHobbies;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    PhysicalAttributes({
        this.id,
        this.userId,
        this.height,
        this.weight,
        this.bloodGroup,
        this.eyeColor,
        this.hairColor,
        this.complexion,
        this.disabilities,
        this.drinkingHabit,
        this.smokingHabit,
        this.bio,
        this.interestsHobbies,
        this.createdAt,
        this.updatedAt,
    });

    factory PhysicalAttributes.fromJson(Map<String, dynamic> json) => PhysicalAttributes(
        id: json["id"],
        userId: json["user_id"],
        height: json["height"],
        weight: json["weight"],
        bloodGroup: json["blood_group"],
        eyeColor: json["eye_color"],
        hairColor: json["hair_color"],
        complexion: json["complexion"],
        disabilities: json["disabilities"],
        drinkingHabit: json["drinking_habit"],
        smokingHabit: json["smoking_habit"],
        bio: json["bio"],
        interestsHobbies: json["interests_hobbies"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "height": height,
        "weight": weight,
        "blood_group": bloodGroup,
        "eye_color": eyeColor,
        "hair_color": hairColor,
        "complexion": complexion,
        "disabilities": disabilities,
        "drinking_habit": drinkingHabit,
        "smoking_habit": smokingHabit,
        "bio": bio,
        "interests_hobbies": interestsHobbies,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
