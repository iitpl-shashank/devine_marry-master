import 'dart:convert';

class DataModel {
  final List<MaritalStatus> maritalStatuses;
  final List<Gender> genders;
  final List<Qualification> qualifications;
  final List<Smoking> smoking;
  final List<Drinking> drinking;
  final List<BloodGroup> bloodGroups;
  final List<Complexion> complexion;
  final List<Disability> disabilities;

  DataModel(
      {required this.maritalStatuses,
      required this.genders,
      required this.qualifications,
      required this.smoking,
      required this.drinking,
      required this.bloodGroups,
      required this.complexion,
      required this.disabilities,

      });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      maritalStatuses: (json['maritalStatuses'] as List?)
              ?.map((e) => MaritalStatus.fromJson(e))
              .toList() ??
          [],
      genders:
          (json['gender'] as List?)?.map((e) => Gender.fromJson(e)).toList() ??
              [],
      qualifications: (json['qualification'] as List?)
              ?.map((e) => Qualification.fromJson(e))
              .toList() ??
          [],
      smoking: (json['smoking'] as List?)
              ?.map((e) => Smoking.fromJson(e))
              .toList() ??
          [],
      drinking: (json['drinking'] as List?)
              ?.map((e) => Drinking.fromJson(e))
              .toList() ??
          [],
      bloodGroups: (json['BloodGroup'] as List?)
              ?.map((e) => BloodGroup.fromJson(e))
              .toList() ??
          [],
      complexion: (json['Complexion'] as List?)
          ?.map((e) => Complexion.fromJson(e))
          .toList() ??
          [],
      disabilities: (json['disability_options'] as List?)
          ?.map((e) => Disability.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maritalStatuses': maritalStatuses.map((e) => e.toJson()).toList(),
      'gender': genders.map((e) => e.toJson()).toList(),
      'qualification': qualifications.map((e) => e.toJson()).toList(),
      'smoking': smoking.map((e) => e.toJson()).toList(),
      'drinking': drinking.map((e) => e.toJson()).toList(),
      'BloodGroup': bloodGroups.map((e) => e.toJson()).toList(),
      'Complexion': complexion.map((e) => e.toJson()).toList(),

    };
  }
}

class MaritalStatus {
  final int id;
  final String title;

  MaritalStatus({required this.id, required this.title});

  factory MaritalStatus.fromJson(Map<String, dynamic> json) {
    return MaritalStatus(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class Gender {
  final int id;
  final String gender;

  Gender({required this.id, required this.gender});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: (json['id'] as num?)?.toInt() ?? 0,
      gender: json['gender']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
    };
  }
}

class LookingFor {
  final int id;
  final String title;

  LookingFor({required this.id, required this.title});

  factory LookingFor.fromJson(Map<String, dynamic> json) {
    return LookingFor(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class Qualification {
  final int id;
  final String name;

  Qualification({required this.id, required this.name});

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}

class Smoking {
  final int id;
  final String name;

  Smoking({required this.id, required this.name});

  factory Smoking.fromJson(Map<String, dynamic> json) {
    return Smoking(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}

class Drinking {
  final int id;
  final String name;

  Drinking({required this.id, required this.name});

  factory Drinking.fromJson(Map<String, dynamic> json) {
    return Drinking(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}

class BloodGroup {
  final int id;
  final String name;

  BloodGroup({required this.id, required this.name});

  factory BloodGroup.fromJson(Map<String, dynamic> json) {
    return BloodGroup(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}

class DegreeResponse {
  final List<Degree> Degrees;

  DegreeResponse({required this.Degrees});

  factory DegreeResponse.fromJson(Map<String, dynamic> json) {
    return DegreeResponse(
      Degrees: (json['data'] as List).map((e) => Degree.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': Degrees.map((e) => e.toJson()).toList(),
    };
  }
}

class Degree {
  final int id;
  final String name;

  Degree({
    required this.id,
    required this.name,
  });

  factory Degree.fromJson(Map<String, dynamic> json) {
    return Degree(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Complexion {
  final int id;
  final String name;

  Complexion({
    required this.id,
    required this.name,
  });

  factory Complexion.fromJson(Map<String, dynamic> json) {
    return Complexion(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class Disability {
  final int id;
  final String name;

  Disability({
    required this.id,
    required this.name,
  });

  factory Disability.fromJson(Map<String, dynamic> json) {
    return Disability(
      id: json['id'],
      name: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': name,
    };
  }
}
