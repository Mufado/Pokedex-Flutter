import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/application/filter_cubit.dart';
import 'package:pokedex_app/application/pokemon_details_cubit.dart';
import 'package:pokedex_app/domain/abstraction/base_pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/presentation/pages/pokemon_details_page.dart';
import 'package:pokedex_app/presentation/widget/pokemon_card.dart';
import 'package:pokedex_app/presentation/widget/search_pokemon_bar.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key, required});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  int? _fetchPageOffset = 0;
  Timer? _debounce;
  final _searchController = TextEditingController();
  late final BasePokemonsRepository _pokemonsRepo;
  late final PagingController<int, NamedAPIResource> _pagingController;
  late final FilterCubit _filtersCubit;

  @override
  void initState() {
    super.initState();
    _pokemonsRepo = context.read<BasePokemonsRepository>();
    _filtersCubit = context.read<FilterCubit>();
    _filtersCubit.loadFilterOptions();

    _pagingController = PagingController<int, NamedAPIResource>(
      getNextPageKey: (state) {
        return _fetchPageOffset;
      },
      fetchPage: (_) async {
        var typesFilters = <String>[];
        var generationsFilters = <String>[];

        if (_filtersCubit.state is FilterLoaded) {
          final currentState = _filtersCubit.state as FilterLoaded;
          typesFilters = currentState.enabledTypes;
          generationsFilters = currentState.enabledGenerations;
        }

        final result = await _pokemonsRepo.getPokemons(
          offset: _fetchPageOffset,
          limit: 20,
          searchQuery: _searchController.text.trim(),
          types: typesFilters,
          generations: generationsFilters,
        );

        _fetchPageOffset = result.nextOffset;

        bool isDuplicatedData =
            _pagingController.items != null &&
            result.pokemonResources.any(_pagingController.items!.contains);

        return isDuplicatedData
            ? <NamedAPIResource>[]
            : result.pokemonResources;
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTapPokemon(NamedAPIResource pokemonData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => PokemonDetailsCubit(
            repository: context.read<BasePokemonsRepository>(),
          ),
          child: PokemonDetailsPage(pokemonResource: pokemonData),
        ),
      ),
    );
  }

  void _onSearchChange() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _fetchPageOffset = 0;
      _pagingController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            SearchPokemonBar(
              searchController: _searchController,
              onChange: _onSearchChange,
            ),
            Expanded(
              child: PagingListener(
                controller: _pagingController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, NamedAPIResource>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate:
                          PagedChildBuilderDelegate<NamedAPIResource>(
                            itemBuilder: (context, pokemonData, index) =>
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: PokemonCard(
                                    pokemonData: pokemonData,
                                    onTap: () => _onTapPokemon(pokemonData),
                                  ),
                                ),
                            firstPageErrorIndicatorBuilder: (context) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Error: ${_pagingController.error}',
                                    style: TextTheme.of(context).headlineSmall,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _pagingController.refresh(),
                                    child: Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
