import 'package:dio/dio.dart';
import 'package:pokedex_app/data/network/abstraction/base_pokemon_data_source.dart';
import 'package:pokedex_app/data/network/dto/pokemon_dto.dart';
import 'package:pokedex_app/domain/exception/network_exception.dart';

class PokeApiClient implements BasePokemonsDataSource {
  late final Dio _dio;

  PokeApiClient({required String baseUrl}) {
    _dio = Dio()..options.baseUrl = baseUrl;
  }

  @override
  Future<NamedAPIResourceListDTO> getPokemons({int? offset, int? limit}) async {
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
      return NamedAPIResourceListDTO.fromJson(
        response.data as Map<String, dynamic>,
      );
    } else {
      throw Exception('Could not get pokemon list.');
    }
  }

  @override
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

  @override
  Future<NamedAPIResourceListDTO> getTypes() async {
    final response = await _dio.get('type');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return NamedAPIResourceListDTO.fromJson(
        response.data as Map<String, dynamic>,
      );
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }

  @override
  Future<NamedAPIResourceListDTO> getGenerations() async {
    final response = await _dio.get('generation');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return NamedAPIResourceListDTO.fromJson(
        response.data as Map<String, dynamic>,
      );
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }

  @override
  Future<TypeDTO> getType(String typeName) async {
    final response = await _dio.get('type/$typeName');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return TypeDTO.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }

  @override
  Future<GenerationDTO> getGeneration(String generationName) async {
    final response = await _dio.get('generation/$generationName');

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return GenerationDTO.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Could not get pokemon details.');
    }
  }
}
