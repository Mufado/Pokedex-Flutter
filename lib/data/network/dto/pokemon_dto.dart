import 'package:json_annotation/json_annotation.dart';

part 'pokemon_dto.g.dart';

@JsonSerializable()
class NamedAPIResourceListDTO {
  final List<NamedAPIResourceDTO> results;

  const NamedAPIResourceListDTO({required this.results});

  factory NamedAPIResourceListDTO.fromJson(Map<String, dynamic> json) =>
      _$NamedAPIResourceListDTOFromJson(json);
}

@JsonSerializable()
class NamedAPIResourceDTO {
  final String? name;
  final String? url;

  const NamedAPIResourceDTO({this.name, this.url});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NamedAPIResourceDTO &&
            other.name == name &&
            other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => name.hashCode;

  factory NamedAPIResourceDTO.fromJson(Map<String, dynamic> json) =>
      _$NamedAPIResourceDTOFromJson(json);
}

@JsonSerializable()
class PokemonDTO {
  final int id;
  final List<PokemonAbilityDTO> abilities;
  final int height;
  final String? name;
  final PokemonSpritesDTO sprites;
  final List<PokemonTypeDTO> types;
  final int weight;

  PokemonDTO({
    required this.abilities,
    required this.height,
    required this.id,
    this.name,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory PokemonDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonDTOFromJson(json);
}

@JsonSerializable()
class PokemonAbilityDTO {
  final NamedAPIResourceDTO ability;

  PokemonAbilityDTO({required this.ability});

  factory PokemonAbilityDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityDTOFromJson(json);
}

@JsonSerializable()
class AbilityDTO {
  final String? name;

  AbilityDTO({required this.name});

  factory AbilityDTO.fromJson(Map<String, dynamic> json) =>
      _$AbilityDTOFromJson(json);
}

@JsonSerializable()
class PokemonSpritesDTO {
  @JsonKey(name: 'front_default')
  final String? frontDefault;

  PokemonSpritesDTO({this.frontDefault});

  factory PokemonSpritesDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesDTOFromJson(json);
}

@JsonSerializable()
class PokemonTypeDTO {
  final NamedAPIResourceDTO type;

  PokemonTypeDTO({required this.type});

  factory PokemonTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeDTOFromJson(json);
}

@JsonSerializable()
class TypeDTO {
  final String? name;
  @JsonKey(name: 'pokemon')
  final List<TypePokemonDTO> pokemons;

  TypeDTO({this.name, required this.pokemons});

  factory TypeDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeDTOFromJson(json);
}

@JsonSerializable()
class TypePokemonDTO {
  final NamedAPIResourceDTO pokemon;

  TypePokemonDTO({required this.pokemon});

  factory TypePokemonDTO.fromJson(Map<String, dynamic> json) =>
      _$TypePokemonDTOFromJson(json);
}

@JsonSerializable()
class GenerationDTO {
  final String? name;
  @JsonKey(name: 'pokemon_species')
  final List<NamedAPIResourceDTO> pokemons;

  GenerationDTO({this.name, required this.pokemons});

  factory GenerationDTO.fromJson(Map<String, dynamic> json) =>
      _$GenerationDTOFromJson(json);
}
