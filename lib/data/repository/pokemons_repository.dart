import 'package:pokedex_app/data/network/client/api_client.dart';
import 'package:pokedex_app/domain/abstraction/base_pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/data/network/network_mapper.dart';

class PokemonsRepository implements BasePokemonsRepository {
  final ApiClient apiClient;

  PokemonsRepository({required this.apiClient});

  @override
  Future<SearchPokemonResult> getPokemons({
    int? offset,
    int? limit,
    String? searchQuery,
    List<String>? types,
    List<String>? generations,
  }) async {
    offset ??= 0;
    limit ??= 20;

    final hasNameFilter = (searchQuery?.isNotEmpty ?? false);
    final hasTypesFilter = (types?.isNotEmpty ?? false);
    final hasGenerationFilter = (generations?.isNotEmpty ?? false);

    if (!hasNameFilter && !hasTypesFilter && !hasGenerationFilter) {
      return SearchPokemonResult(
        pokemonResources: (await apiClient.getPokemons(
          offset: offset,
          limit: limit,
        )).results.toEntities(),
        nextOffset: offset + limit,
      );
    }

    if (!hasTypesFilter && !hasGenerationFilter) {
      return await _getPokemonsByName(
        name: searchQuery!,
        offset: offset,
        limit: limit,
      );
    }

    var filteredByTypes = hasTypesFilter
        ? (await _getPokemonsByFilter(
            filterNames: types!,
            getResourcesCallback: (int filterIndex) async {
              return (await apiClient.getType(
                types[filterIndex],
              )).pokemons.toResourcesEntities();
            },
          )).toSet()
        : <NamedAPIResource>{};

    var filteredByGenerations = hasGenerationFilter
        ? (await _getPokemonsByFilter(
            filterNames: generations!,
            name: searchQuery,
            getResourcesCallback: (int filterIndex) async {
              return (await apiClient.getGeneration(
                generations[filterIndex],
              )).pokemons.toEntities(convertToPokemonUrl: true);
            },
          )).toSet()
        : <NamedAPIResource>{};

    final Set<NamedAPIResource> filteredList;

    if (hasTypesFilter && hasGenerationFilter) {
      filteredList = hasGenerationFilter
          ? filteredByTypes.intersection(filteredByGenerations)
          : filteredByTypes;
    } else if (hasTypesFilter) {
      filteredList = filteredByTypes;
    } else {
      filteredList = filteredByGenerations;
    }

    if (hasNameFilter) {
      filteredList.removeWhere(
        (resource) =>
            !resource.name.toLowerCase().contains(searchQuery!.toLowerCase()),
      );
    }

    return SearchPokemonResult(
      pokemonResources: filteredList.toList(),
      nextOffset: null,
    );
  }

  @override
  Future<Pokemon> getPokemonDetails({required String pokemonUrl}) async {
    return (await apiClient.getPokemonDetails(url: pokemonUrl)).toEntity();
  }

  @override
  Future<List<FilterOption>> getTypesFilters() async {
    return (await apiClient.getTypes()).results.toTypesFilterOptions();
  }

  @override
  Future<List<FilterOption>> getGenerationsFilters() async {
    return (await apiClient.getGenerations()).results
        .toGenerationFilterOptions();
  }

  Future<SearchPokemonResult> _getPokemonsByName({
    required String name,
    required int offset,
    required int limit,
  }) async {
    int? nextOffset = offset;
    final returnList = <NamedAPIResource>[];

    while (returnList.length < limit) {
      final results = (await apiClient.getPokemons(
        offset: nextOffset,
        limit: limit,
      )).results.toEntities();

      returnList.addAll(
        results.where(
          (result) => result.name.toLowerCase().contains(name.toLowerCase()),
        ),
      );

      bool reachedLastPage = results.length < limit;

      if (reachedLastPage) {
        nextOffset = null;
        break;
      }

      nextOffset = nextOffset! + limit;
    }

    if (returnList.length > limit) {
      final removeQuantity = returnList.length - limit;

      returnList.removeRange(
        returnList.length - removeQuantity,
        returnList.length,
      );
    }

    return SearchPokemonResult(
      pokemonResources: returnList,
      nextOffset: nextOffset,
    );
  }

  Future<List<NamedAPIResource>> _getPokemonsByFilter({
    required List<String> filterNames,
    required Future<List<NamedAPIResource>> Function(int filterIndex)
    getResourcesCallback,
    String? name,
  }) async {
    var pokemonsResources = <NamedAPIResource>{};

    if (filterNames.isEmpty) {
      return pokemonsResources.toList();
    }

    pokemonsResources = (await getResourcesCallback(0)).toSet();

    if (filterNames.length == 1) {
      return pokemonsResources.toList();
    }

    for (var i = 1; i < filterNames.length; i++) {
      final result = (await getResourcesCallback(i)).toSet();

      pokemonsResources.addAll(result);
    }

    return pokemonsResources.toList();
  }
}
