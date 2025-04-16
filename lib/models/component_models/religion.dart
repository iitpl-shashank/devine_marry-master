import 'dart:convert';

class ReligionResponse {
  final List<Religion> religions;

  ReligionResponse({required this.religions});

  factory ReligionResponse.fromJson(Map<String, dynamic> json) {
    return ReligionResponse(
      religions: (json['religions'] as List).map((e) => Religion.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'religions': religions.map((e) => e.toJson()).toList(),
    };
  }
}

class Religion {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Religion({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}



class CasteResponse {
  final List<Caste> castes;

  CasteResponse({required this.castes});

  factory CasteResponse.fromJson(Map<String, dynamic> json) {
    return CasteResponse(
      castes: (json['castes'] as List).map((e) => Caste.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'castes': castes.map((e) => e.toJson()).toList(),
    };
  }
}

class Caste {
  final int id;
  final String name;

  Caste({
    required this.id,
    required this.name,
  });

  factory Caste.fromJson(Map<String, dynamic> json) {
    return Caste(
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
