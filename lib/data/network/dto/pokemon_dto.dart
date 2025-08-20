import 'package:json_annotation/json_annotation.dart';

part 'pokemon_dto.g.dart';

@JsonSerializable()
class PokemonDTO {
  int id;
  List<PokemonAbility> abilities;
  int height;
  String name;
  PokemonSprites sprites;
  List<PokemonType> types;
  int weight;

  PokemonDTO({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory PokemonDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonDTOFromJson(json);
}

@JsonSerializable()
class PokemonAbility {
  Ability ability;

  PokemonAbility({required this.ability});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);
}

@JsonSerializable()
class Ability {
  String name;

  Ability({required this.name});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
}

@JsonSerializable()
class PokemonSprites {
  @JsonKey(name: 'front_default')
  String? frontDefault;

  PokemonSprites({required this.frontDefault});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesFromJson(json);
}

@JsonSerializable()
class PokemonType {
  TypeDTO type;

  PokemonType({required this.type});

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);
}

@JsonSerializable()
class TypeResponseDTO {
  List<TypeDTO> results;

  TypeResponseDTO({required this.results});

  factory TypeResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeResponseDTOFromJson(json);
}

@JsonSerializable()
class TypeDTO {
  String name;

  TypeDTO({required this.name});

  factory TypeDTO.fromJson(Map<String, dynamic> json) =>
      _$TypeDTOFromJson(json);
}

@JsonSerializable()
class GenerationResponseDTO {
  List<GenerationDTO> results;

  GenerationResponseDTO({required this.results});

  factory GenerationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GenerationResponseDTOFromJson(json);
}

@JsonSerializable()
class GenerationDTO {
  String name;

  GenerationDTO({required this.name});

  factory GenerationDTO.fromJson(Map<String, dynamic> json) =>
      _$GenerationDTOFromJson(json);
}