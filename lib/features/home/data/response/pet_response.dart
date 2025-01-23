class PetResponse {
  PetResponse({
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

  factory PetResponse.fromJson(Map<String, dynamic> json) {
    return PetResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      price: json['price'] as int,
      type: json['type'] as String,
      breed: json['breed'] as String,
      imageUrl: json['imageUrl'] as String,
      adopted: json['adopted'] as bool,
      color: json['color'] as String,
      gender: json['gender'] as String,
      weight: json['weight'] as String,
      vaccinated: json['vaccinated'] as bool,
    );
  }
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
