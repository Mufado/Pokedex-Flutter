import 'package:pokedex_app/domain/entity/pokemon.dart';

abstract class BasePokemonsRepository {
  Future<SearchPokemonResult> getPokemons({
    int? offset,
    int? limit,
    String? searchQuery,
    List<String>? types,
    List<String>? generations,
  });
  Future<Pokemon> getPokemonDetails({required String pokemonUrl});
  Future<List<FilterOption>> getTypesFilters();
  Future<List<FilterOption>> getGenerationsFilters();
}
