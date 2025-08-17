// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_pokemons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPokemons _$AllPokemonsFromJson(Map<String, dynamic> json) => AllPokemons(
  results: (json['results'] as List<dynamic>)
      .map((e) => PokemonName.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllPokemonsToJson(AllPokemons instance) =>
    <String, dynamic>{'results': instance.results};

PokemonName _$PokemonNameFromJson(Map<String, dynamic> json) =>
    PokemonName(name: json['name'] as String);

Map<String, dynamic> _$PokemonNameToJson(PokemonName instance) =>
    <String, dynamic>{'name': instance.name};
