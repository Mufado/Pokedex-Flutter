import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/application/pokemon_details_cubit.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
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
  final _searchController = TextEditingController();
  late final PokemonsRepository _pokemonsRepo;
  late final PagingController<int, PokemonData> _pagingController;

  @override
  void initState() {
    super.initState();
    _pokemonsRepo = context.read<PokemonsRepository>();
    _pagingController = PagingController<int, PokemonData>(
      getNextPageKey: (state) {
        return _fetchPageOffset;
      },
      fetchPage: (_) async {
        final result = await _pokemonsRepo.getAllPokemons(
          offset: _fetchPageOffset,
          limit: 20,
          searchQuery: _searchController.text.trim(),
        );
        _fetchPageOffset = result.nextOffset;
        bool isDuplicatedData =
            _pagingController.items != null &&
            result.pokemonData.any(_pagingController.items!.contains);
        return isDuplicatedData ? <PokemonData>[] : result.pokemonData;
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
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

  void _onSearchInputChange(String _) {
    _fetchPageOffset = 0;
    _pagingController.refresh();
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
              onChange: _onSearchInputChange,
            ),
            Expanded(
              child: PagingListener(
                controller: _pagingController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, PokemonData>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<PokemonData>(
                        itemBuilder: (context, pokemonData, index) => Container(
                          padding: EdgeInsets.all(8),
                          child: PokemonCard(
                            pokemonData: pokemonData,
                            onTap: () => _onTapPokemon(pokemonData),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (context) =>
                            Icon(Icons.error),
                        newPageErrorIndicatorBuilder: (context) =>
                            Icon(Icons.error_outline),
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
