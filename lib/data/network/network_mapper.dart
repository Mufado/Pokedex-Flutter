import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/mapper_exeception.dart';
import 'package:pokedex_app/domain/model/pokemon.dart';

extension on PokemonDTO {
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

extension on List<PokemonDTO> {
  List<Pokemon> toPokemons() => map((dto) => dto.toEntity()).toList();
}
