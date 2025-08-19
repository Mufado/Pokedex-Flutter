import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/application/pokemon_details_cubit.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/presentation/pages/pokemon_details_page.dart';
import 'package:pokedex_app/presentation/widget/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key, required});

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

  void _onTapPokemon(PokemonData pokemonData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => PokemonDetailsCubit(
            repository: context.read<PokemonsRepository>(),
          ),
          child: PokemonDetailsPage(pokemonData: pokemonData),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) =>
            PagedListView<int, PokemonData>(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<PokemonData>(
                itemBuilder: (context, pokemonData, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: PokemonCard(
                    pokemonData: pokemonData,
                    onTap: () => _onTapPokemon(pokemonData),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
