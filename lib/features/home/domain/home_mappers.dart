import 'package:pet_adoption_assignment/features/home/data/response/pet_response.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';

class HomeMappers {
  static List<PetHome> mapPetToHome(List<PetResponse> petResponse) {
    return petResponse
        .map(
          (e) => PetHome(
            breed: e.breed,
            type: e.type,
            weight: e.weight,
            name: e.name,
            id: e.id,
            imageUrl: e.imageUrl,
            gender: e.gender,
            adopted: e.adopted,
            age: e.age,
            color: e.color,
            price: e.price,
            vaccinated: e.vaccinated,
          ),
        )
        .toList();
  }
}
