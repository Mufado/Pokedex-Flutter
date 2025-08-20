// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDTO _$PokemonDTOFromJson(Map<String, dynamic> json) => PokemonDTO(
  abilities: (json['abilities'] as List<dynamic>)
      .map((e) => PokemonAbility.fromJson(e as Map<String, dynamic>))
      .toList(),
  height: (json['height'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sprites: PokemonSprites.fromJson(json['sprites'] as Map<String, dynamic>),
  types: (json['types'] as List<dynamic>)
      .map((e) => PokemonType.fromJson(e as Map<String, dynamic>))
      .toList(),
  weight: (json['weight'] as num).toInt(),
);

Map<String, dynamic> _$PokemonDTOToJson(PokemonDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'abilities': instance.abilities,
      'height': instance.height,
      'name': instance.name,
      'sprites': instance.sprites,
      'types': instance.types,
      'weight': instance.weight,
    };

PokemonAbility _$PokemonAbilityFromJson(Map<String, dynamic> json) =>
    PokemonAbility(
      ability: Ability.fromJson(json['ability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonAbilityToJson(PokemonAbility instance) =>
    <String, dynamic>{'ability': instance.ability};

Ability _$AbilityFromJson(Map<String, dynamic> json) =>
    Ability(name: json['name'] as String);

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
  'name': instance.name,
};

PokemonSprites _$PokemonSpritesFromJson(Map<String, dynamic> json) =>
    PokemonSprites(frontDefault: json['front_default'] as String?);

Map<String, dynamic> _$PokemonSpritesToJson(PokemonSprites instance) =>
    <String, dynamic>{'front_default': instance.frontDefault};

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) =>
    PokemonType(type: Type.fromJson(json['type'] as Map<String, dynamic>));

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{'type': instance.type};

Type _$TypeFromJson(Map<String, dynamic> json) =>
    Type(name: json['name'] as String);

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
  'name': instance.name,
};
