// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedAPIResourceListDTO _$NamedAPIResourceListDTOFromJson(
  Map<String, dynamic> json,
) => NamedAPIResourceListDTO(
  results: (json['results'] as List<dynamic>)
      .map((e) => NamedAPIResourceDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NamedAPIResourceListDTOToJson(
  NamedAPIResourceListDTO instance,
) => <String, dynamic>{'results': instance.results};

NamedAPIResourceDTO _$NamedAPIResourceDTOFromJson(Map<String, dynamic> json) =>
    NamedAPIResourceDTO(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$NamedAPIResourceDTOToJson(
  NamedAPIResourceDTO instance,
) => <String, dynamic>{'name': instance.name, 'url': instance.url};

PokemonDTO _$PokemonDTOFromJson(Map<String, dynamic> json) => PokemonDTO(
  abilities: (json['abilities'] as List<dynamic>)
      .map((e) => PokemonAbilityDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  height: (json['height'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  sprites: PokemonSpritesDTO.fromJson(json['sprites'] as Map<String, dynamic>),
  types: (json['types'] as List<dynamic>)
      .map((e) => PokemonTypeDTO.fromJson(e as Map<String, dynamic>))
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

PokemonAbilityDTO _$PokemonAbilityDTOFromJson(Map<String, dynamic> json) =>
    PokemonAbilityDTO(
      ability: NamedAPIResourceDTO.fromJson(
        json['ability'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PokemonAbilityDTOToJson(PokemonAbilityDTO instance) =>
    <String, dynamic>{'ability': instance.ability};

AbilityDTO _$AbilityDTOFromJson(Map<String, dynamic> json) =>
    AbilityDTO(name: json['name'] as String?);

Map<String, dynamic> _$AbilityDTOToJson(AbilityDTO instance) =>
    <String, dynamic>{'name': instance.name};

PokemonSpritesDTO _$PokemonSpritesDTOFromJson(Map<String, dynamic> json) =>
    PokemonSpritesDTO(frontDefault: json['front_default'] as String?);

Map<String, dynamic> _$PokemonSpritesDTOToJson(PokemonSpritesDTO instance) =>
    <String, dynamic>{'front_default': instance.frontDefault};

PokemonTypeDTO _$PokemonTypeDTOFromJson(Map<String, dynamic> json) =>
    PokemonTypeDTO(
      type: NamedAPIResourceDTO.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeDTOToJson(PokemonTypeDTO instance) =>
    <String, dynamic>{'type': instance.type};

TypeDTO _$TypeDTOFromJson(Map<String, dynamic> json) => TypeDTO(
  name: json['name'] as String?,
  pokemons: (json['pokemon'] as List<dynamic>)
      .map((e) => TypePokemonDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TypeDTOToJson(TypeDTO instance) => <String, dynamic>{
  'name': instance.name,
  'pokemon': instance.pokemons,
};

TypePokemonDTO _$TypePokemonDTOFromJson(Map<String, dynamic> json) =>
    TypePokemonDTO(
      pokemon: NamedAPIResourceDTO.fromJson(
        json['pokemon'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TypePokemonDTOToJson(TypePokemonDTO instance) =>
    <String, dynamic>{'pokemon': instance.pokemon};

GenerationDTO _$GenerationDTOFromJson(Map<String, dynamic> json) =>
    GenerationDTO(
      name: json['name'] as String?,
      pokemons: (json['pokemon_species'] as List<dynamic>)
          .map((e) => NamedAPIResourceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenerationDTOToJson(GenerationDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pokemon_species': instance.pokemons,
    };
