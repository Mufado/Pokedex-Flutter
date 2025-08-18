import 'package:pokedex_app/data/network/dto/all_pokemons_dto.dart';
import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/mapper_exeception.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

extension PokemonDtoToEntity on PokemonDTO {
  Pokemon toEntity() {
    try {
      return Pokemon(
        id: id,
        name: name,
        sprite: sprites.frontDefault,
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

extension PokemonDataDtoToEntity on PokemonDataDTO {
  PokemonData toEntity() => PokemonData(name: name, url: url);
}

extension PokemonDataDtoListToEntities on List<PokemonDataDTO> {
  List<PokemonData> toEntities() => map((dto) => dto.toEntity()).toList();
}
