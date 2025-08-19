import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/presentation/widget/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late final PokemonsRepository _pokemonsRepo;
  late final PagingController<int, PokemonData> _pagingController;

  @override
  void initState() {
    super.initState();
    _pokemonsRepo = context.read<PokemonsRepository>();
    _pagingController = PagingController<int, PokemonData>(
      getNextPageKey: (state) => state.keys == null
          ? 0
          : (state.lastPageIsEmpty
                ? null
                : (state.keys![state.keys!.length - 1] + 20)),
      fetchPage: (offset) =>
          _pokemonsRepo.getAllPokemons(offset: offset, limit: 20),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex'), centerTitle: true),
      body: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) =>
            PagedListView<int, PokemonData>(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<PokemonData>(
                itemBuilder: (context, pokemonData, index) => Container(
                  padding: EdgeInsets.only(
                    left: 100,
                    top: 8,
                    right: 100,
                    bottom: 8,
                  ),
                  child: PokemonCard(pokemonData: pokemonData),
                ),
              ),
            ),
      ),
    );
  }
}
