import 'package:pokedex_app/data/network/dto/all_pokemons_dto.dart';
import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/mapper_exeception.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

extension PokemonDtoToEntity on PokemonDTO {
  Pokemon toEntity() {
    try {
      return Pokemon(
        id: id,
        name: name.replaceAll('-', ' '),
        spriteUrl: sprites.frontDefault,
        height: height,
        weight: weight,
        abilities: abilities
            .map((abilities) => abilities.ability.name)
            .toList(),
        types: types.map((types) => types.type.name).toList(),
      );
    } catch (e) {
      throw MapperExeception<PokemonDTO, Pokemon>(e.toString());
    }
  }
}

extension PokemonDTOListToEntities on List<PokemonDTO> {
  List<Pokemon> toEntities() => map((dto) => dto.toEntity()).toList();
}

extension PokemonDataDTOToEntity on PokemonDataDTO {
  PokemonData toEntity() =>
      PokemonData(name: name.replaceAll('-', ' '), url: url);
}

extension PokemonDataDTOListToEntities on List<PokemonDataDTO> {
  List<PokemonData> toEntities() => map((dto) => dto.toEntity()).toList();
}

extension TypeDTOToEntity on TypeDTO {
  FilterOption toEntity() => FilterOption(name: name);
}

extension TypeDTOListToEntities on List<TypeDTO> {
  List<FilterOption> toEntities() => map((dto) => dto.toEntity()).toList();
}

extension GenerationDTOToEntity on GenerationDTO {
  FilterOption toEntity() {
    final generation = name.split('-');
    return generation.length > 1
        ? FilterOption(name: generation[generation.length - 1])
        : FilterOption(name: name);
  }
}

extension GenerationDTOListToEntities on List<GenerationDTO> {
  List<FilterOption> toEntities() => map((dto) => dto.toEntity()).toList();
}
