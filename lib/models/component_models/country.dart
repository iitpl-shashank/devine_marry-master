class CountryResponse {
  final List<Country> countries;

  CountryResponse({required this.countries});

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      countries: (json['data']['countries'] as List)
          .map((e) => Country.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'countries': countries.map((e) => e.toJson()).toList(),
      },
    };
  }
}

class Country {
  final int id;
  final String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
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



class StateResponse {
  final List<StateModel> states;

  StateResponse({required this.states});

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      states: (json['states'] as List).map((e) => StateModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'states': states.map((e) => e.toJson()).toList(),
    };
  }
}

class StateModel {
  final int id;
  final String name;

  StateModel({
    required this.id,
    required this.name,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
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

