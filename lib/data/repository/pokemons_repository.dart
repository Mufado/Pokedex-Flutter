import 'package:pokedex_app/data/network/client/api_client.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/data/network/network_mapper.dart';

class PokemonsRepository {
  final ApiClient apiClient;

  PokemonsRepository({required this.apiClient});

  Future<List<PokemonData>> getAllPokemons({int? offset, int? limit}) async {
    return (await apiClient.getAllPokemons(
      offset: offset,
      limit: limit,
    )).results.toEntities();
  }

  Future<Pokemon> getPokemonDetails(String pokemonUrl) async {
    return (await apiClient.getPokemonDetails(url: pokemonUrl)).toEntity();
  }
}
