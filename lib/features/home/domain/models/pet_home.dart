class PetHome {
  PetHome({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.type,
    required this.breed,
    required this.imageUrl,
    required this.adopted,
    required this.color,
    required this.gender,
    required this.weight,
    required this.vaccinated,
  });

  final int id;
  final String name;
  final int age;
  final int price;
  final String type;
  final String breed;
  final String imageUrl;
  final bool adopted;
  final String color;
  final String gender;
  final String weight;
  final bool vaccinated;

  PetHome copyWith({
    int? id,
    String? name,
    int? age,
    int? price,
    String? type,
    String? breed,
    String? imageUrl,
    bool? adopted,
    String? color,
    String? gender,
    String? weight,
    bool? vaccinated,
  }) {
    return PetHome(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      price: price ?? this.price,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      imageUrl: imageUrl ?? this.imageUrl,
      adopted: adopted ?? this.adopted,
      color: color ?? this.color,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      vaccinated: vaccinated ?? this.vaccinated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'price': price,
      'type': type,
      'breed': breed,
      'imageUrl': imageUrl,
      'adopted': adopted,
      'color': color,
      'gender': gender,
      'weight': weight,
      'vaccinated': vaccinated,
    };
  }
}
