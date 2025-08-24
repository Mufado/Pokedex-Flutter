import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/domain/abstraction/base_pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

abstract class FilterState {
  const FilterState();
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<FilterOption> types;
  final List<FilterOption> generations;
  final List<String> enabledTypes;
  final List<String> enabledGenerations;

  const FilterLoaded({
    required this.types,
    required this.generations,
    required this.enabledTypes,
    required this.enabledGenerations,
  });
}

class FilterError extends FilterState {
  final String message;

  const FilterError(this.message);
}

class FilterCubit extends Cubit<FilterState> {
  final BasePokemonsRepository _repository;

  FilterCubit({required BasePokemonsRepository repository})
    : _repository = repository,
      super(FilterInitial());

  Future<void> loadFilterOptions() async {
    emit(FilterLoading());

    try {
      final types = await _repository.getTypesFilters();
      final generations = await _repository.getGenerationsFilters();
      emit(
        FilterLoaded(
          types: types,
          generations: generations,
          enabledTypes: [],
          enabledGenerations: [],
        ),
      );
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }

  void triggerFilter({String? type, String? generation}) {
    if (state is! FilterLoaded) {
      return;
    }

    final currentState = state as FilterLoaded;
    
    if (type != null) {
      currentState.enabledTypes.contains(type) ? currentState.enabledTypes.remove(type) : currentState.enabledTypes.add(type);
    }

    if (generation != null) {
      currentState.enabledGenerations.contains(generation) ? currentState.enabledGenerations.remove(generation) : currentState.enabledGenerations.add(generation);
    }

    emit(
      FilterLoaded(
        types: currentState.types,
        generations: currentState.generations,
        enabledTypes: type == 'ALL' ? [] : currentState.enabledTypes,
        enabledGenerations: generation == 'ALL' ? [] : currentState.enabledGenerations,
      ),
    );
  }
}
