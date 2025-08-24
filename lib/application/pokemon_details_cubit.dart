import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/domain/abstraction/base_pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

abstract class PokemonDetailsState {
  const PokemonDetailsState();
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final Pokemon pokemon;

  const PokemonDetailsLoaded(this.pokemon);
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;

  const PokemonDetailsError(this.message);
}

// Cubit
class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final BasePokemonsRepository _repository;

  PokemonDetailsCubit({required BasePokemonsRepository repository})
    : _repository = repository,
      super(PokemonDetailsInitial());

  Future<void> loadPokemonDetail(String pokemonUrl) async {
    try {
      emit(PokemonDetailsLoading());

      final pokemon = await _repository.getPokemonDetails(pokemonUrl: pokemonUrl);

      emit(PokemonDetailsLoaded(pokemon));
    } catch (e) {
      emit(PokemonDetailsError('Error: $e'));
    }
  }
}
