class Person {
  final String name;
  final String lastname;
  final String gender;
  final DateTime dateOfBirth;

  Person({
    required this.name,
    required this.lastname,
    required this.gender,
    required this.dateOfBirth,
  });
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastname": lastname,
      "gender": gender,
      "dateOfBirth": dateOfBirth.toIso8601String()
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'] ?? "",
      lastname: map['lastname'] ?? "",
      gender: map['gender'] ?? "",
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map["dateOfBirth"])
          : DateTime.now(),
    );
  }
}
