import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';

abstract class BasePokemonsDataSource {
  Future<NamedAPIResourceListDTO> getPokemons({int? offset, int? limit});
  Future<PokemonDTO> getPokemonDetails({required String url});
  Future<NamedAPIResourceListDTO> getTypes();
  Future<NamedAPIResourceListDTO> getGenerations();
  Future<TypeDTO> getType(String typeName);
  Future<GenerationDTO> getGeneration(String generationName);
}