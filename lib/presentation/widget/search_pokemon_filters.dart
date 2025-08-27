import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/application/filter_cubit.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

class SearchPokemonFilters extends StatefulWidget {
  final void Function()? onChange;

  const SearchPokemonFilters({super.key, this.onChange});

  @override
  State<SearchPokemonFilters> createState() => _SearchPokemonFiltersState();
}

class _SearchPokemonFiltersState extends State<SearchPokemonFilters> {
  late final FilterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FilterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      child: SingleChildScrollView(
        child: Container(
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
                    _getFilterChips(
                      allFilters: state.types,
                      enabledFilters: state.enabledTypes,
                      (filter) {
                        _cubit.triggerFilter(type: filter);
                      },
                      () => _cubit.triggerFilter(type: 'ALL'),
                    ),
                    const SizedBox(height: 16),
                    Text('Generations'),
                    const SizedBox(height: 8),
                    _getFilterChips(
                      allFilters: state.generations,
                      enabledFilters: state.enabledGenerations,
                      (filter) {
                        _cubit.triggerFilter(generation: filter);
                      },
                      () => _cubit.triggerFilter(generation: 'ALL'),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Wrap _getFilterChips(
    void Function(String? filter) triggerFilterCallback,
    void Function() triggerFilterAllCallback, {
    required List<FilterOption> allFilters,
    required List<String> enabledFilters,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        FilterChip(
          label: Text('ALL'),
          selected: enabledFilters.isEmpty,
          onSelected: (value) {
            if (!value) {
              return;
            }
            triggerFilterCallback("ALL");
            widget.onChange!();
          },
          backgroundColor: Colors.red.shade300,
          selectedColor: Colors.red.shade600,
        ),
        ...allFilters.map(
          (filter) => FilterChip(
            label: Text(filter.name.toUpperCase()),
            selected: enabledFilters.contains(filter.apiName),
            onSelected: (value) {
              if (widget.onChange != null) {
                triggerFilterCallback(filter.apiName);
                widget.onChange!();
              }
            },
          ),
        ),
      ],
    );
  }
}
