class Medication {
  final String name;
  final String dose;
  final String time;
  bool taken;

  Medication({required this.name, required this.dose, required this.time, this.taken = false});

  Map<String, dynamic> toMap() {
    return {"name": name, "dose": dose, "time": time, "taken": taken};
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      dose: map['dose'],
      time: map['time'],
      taken: map['taken'],
    );
  }
}
