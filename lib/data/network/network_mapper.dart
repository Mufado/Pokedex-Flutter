import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/mapper_exeception.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

extension NamedAPIResourceDTOToEntity on NamedAPIResourceDTO {
  NamedAPIResource toEntity() =>
      NamedAPIResource(name: name ?? '', url: url ?? '');

  NamedAPIResource toConvertedUrlEntity() => NamedAPIResource(
    name: name ?? '',
    url: url?.replaceFirst('/pokemon-species/', '/pokemon/') ?? '',
  );
}

extension NamedAPIResourceDTOListToEntity on Iterable<NamedAPIResourceDTO> {
  List<NamedAPIResource> toEntities({bool convertToPokemonUrl = false}) => map(
    convertToPokemonUrl
        ? (dto) => dto.toConvertedUrlEntity()
        : (dto) => dto.toEntity(),
  ).toList();

  List<FilterOption> toTypesFilterOptions() {
    return map(
      (dto) => FilterOption(name: dto.name ?? '', apiName: dto.name),
    ).toList();
  }

  List<FilterOption> toGenerationFilterOptions() {
    return map(
      (dto) => FilterOption(
        name: 'GEN ${dto.name?.split('-')[1] ?? List<String>.empty()}',
        apiName: dto.name,
      ),
    ).toList();
  }
}

extension PokemonDTOToEntity on PokemonDTO {
  Pokemon toEntity() {
    try {
      return Pokemon(
        id: id,
        name: name?.replaceAll('-', ' ') ?? '',
        spriteUrl: sprites.frontDefault,
        height: height,
        weight: weight,
        abilities: abilities
            .map((abilities) => abilities.ability.name ?? '')
            .toList(),
        types: types.map((types) => types.type.name ?? '').toList(),
      );
    } catch (e) {
      throw MapperExeception<PokemonDTO, Pokemon>(e.toString());
    }
  }
}

extension PokemonDTOListToEntities on List<PokemonDTO> {
  List<Pokemon> toEntities() => map((dto) => dto.toEntity()).toList();
}

extension TypePokemonDTOListToEntity on Iterable<TypePokemonDTO> {
  List<NamedAPIResource> toResourcesEntities() =>
      map((dto) => dto.pokemon.toEntity()).toList();
}
