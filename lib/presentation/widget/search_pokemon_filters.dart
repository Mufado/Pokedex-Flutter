import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/application/search_filters_cubit.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

class SearchPokemonFilters extends StatefulWidget {
  const SearchPokemonFilters({super.key});

  @override
  State<SearchPokemonFilters> createState() => _SearchPokemonFiltersState();
}

class _SearchPokemonFiltersState extends State<SearchPokemonFilters> {
  late final FilterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FilterCubit>();
    _cubit.loadFilterOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).onPrimaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder(
        bloc: _cubit,
        builder: (context, state) {
          if (state is FilterLoaded) {
            return Column(
              children: [
                Text('Types'),
                const SizedBox(height: 8),
                _getFilterChips(state.types),
                const SizedBox(height: 16),
                Text('Generations'),
                const SizedBox(height: 8),
                _getFilterChips(state.generations),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Wrap _getFilterChips(List<FilterOption> values) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        ...values.map(
          (type) => FilterChip(
            label: Text(type.name.toUpperCase()),
            onSelected: (value) {},
          ),
        ),
      ],
    );
  }
}
