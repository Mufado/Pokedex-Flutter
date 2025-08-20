import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

abstract class FilterState  {
  const FilterState();
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<FilterOption> types;
  final List<FilterOption> generations;

  const FilterLoaded({
    required this.types,
    required this.generations,
  });
}

class FilterError extends FilterState {
  final String message;

  const FilterError(this.message);
}

class FilterCubit extends Cubit<FilterState> {
  final PokemonsRepository _repository;

  FilterCubit({required PokemonsRepository repository})
      : _repository = repository,
        super(FilterInitial());

  Future<void> loadFilterOptions() async {
    emit(FilterLoading());

    try {
      final types = await _repository.getTypesFilters();
      final generations = await _repository.getGenerationsFilters();
      emit(FilterLoaded(types: types, generations: generations));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
} 