import 'package:pokedex_app/data/network/client/api_client.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/data/network/network_mapper.dart';

class PokemonsRepository {
  final ApiClient apiClient;

  PokemonsRepository({required this.apiClient});

  Future<SearchPokemonResult> getAllPokemons({
    int? offset,
    int? limit,
    String? searchQuery,
  }) async {
    limit ??= 20;

    var results = (await apiClient.getAllPokemons(
      offset: offset,
      limit: limit,
    )).results.toEntities();

    int? newOffset = offset == null ? limit : offset + limit;

    if (searchQuery == null || searchQuery.isEmpty) {
      return SearchPokemonResult(
        pokemonData: results,
        nextOffset: results.length < limit ? null : newOffset,
      );
    }

    final returnList = <PokemonData>[];

    returnList.addAll(
      results.where(
        (result) =>
            result.name.toLowerCase().contains(searchQuery.toLowerCase()),
      ),
    );

    // Since an endpoint that allow searching does not exists, the following code will keep
    // sending requests to fetch the pokemons by the search query
    while (returnList.length < limit) {
      results = (await apiClient.getAllPokemons(
        offset: newOffset,
        limit: limit,
      )).results.toEntities();

      returnList.addAll(
        results.where(
          (result) =>
              result.name.toLowerCase().contains(searchQuery.toLowerCase()),
        ),
      );

      if (results.length < limit) {
        newOffset = null;
        break;
      }

      newOffset = newOffset! + limit;
    }

    if (returnList.length > limit) {
      final removeQuantity = returnList.length - limit;

      returnList.removeRange(
        returnList.length - removeQuantity,
        returnList.length,
      );
    }

    return SearchPokemonResult(pokemonData: returnList, nextOffset: newOffset);
  }

  Future<Pokemon> getPokemonDetails({required String pokemonUrl}) async {
    return (await apiClient.getPokemonDetails(url: pokemonUrl)).toEntity();
  }
}
