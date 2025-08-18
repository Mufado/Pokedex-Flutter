// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_pokemons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPokemons _$AllPokemonsFromJson(Map<String, dynamic> json) => AllPokemons(
  results: (json['results'] as List<dynamic>)
      .map((e) => PokemonDataDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllPokemonsToJson(AllPokemons instance) =>
    <String, dynamic>{'results': instance.results};

PokemonDataDTO _$PokemonDataDTOFromJson(Map<String, dynamic> json) =>
    PokemonDataDTO(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$PokemonDataDTOToJson(PokemonDataDTO instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
