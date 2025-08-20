import 'package:dio/dio.dart';
import 'package:pokedex_app/data/network/dto/all_pokemons_dto.dart';
import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/network_exception.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()..options.baseUrl = baseUrl;
  }

  Future<AllPokemons> getAllPokemons({int? offset, int? limit}) async {
    final response = await _dio.get(
      'pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return AllPokemons.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon list.');
    }
  }

  Future<PokemonDTO> getPokemonDetails({required String url}) async {
    final response = await _dio.get(url);

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return PokemonDTO.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }

  Future<TypeResponseDTO> getTypes() async {
    final response = await _dio.get('https://pokeapi.co/api/v2/type');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return TypeResponseDTO.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }

  Future<GenerationResponseDTO> getGenerations() async {
    final response = await _dio.get('https://pokeapi.co/api/v2/generation');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return GenerationResponseDTO.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }
}
