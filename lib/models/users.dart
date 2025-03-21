class Person {
  final String id;
  final String name;
  final String lastname;
  final String gender;
  final DateTime dateOfBirth;

  Person({
    required this.id,
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

  factory Person.fromMap(String id, Map<String, dynamic> map) {
    return Person(
      id: id,
      name: map['name'] ?? "",
      lastname: map['lastname'] ?? "",
      gender: map['gender'] ?? "",
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map["dateOfBirth"])
          : DateTime.now(),
    );
  }
}
