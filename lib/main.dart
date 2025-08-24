import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/application/pokemon_details_cubit.dart';
import 'package:pokedex_app/application/filter_cubit.dart';
import 'package:pokedex_app/data/network/client/api_client.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/domain/abstraction/base_pokemons_repository.dart';
import 'package:pokedex_app/presentation/pages/pokemon_list_page.dart';
import 'package:pokedex_app/presentation/theme/pokedex_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(baseUrl: 'https://pokeapi.co/api/v2/');
    final repository = PokemonsRepository(apiClient: apiClient) as BasePokemonsRepository;

    return MaterialApp(
      title: 'Pokemons',
      theme: PokedexTheme.mixed,
      home: RepositoryProvider(
        create: (_) => repository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PokemonDetailsCubit(repository: repository),
            ),
            BlocProvider(create: (_) => FilterCubit(repository: repository)),
          ],
          child: PokemonListPage(),
        ),
      ),
    );
  }
}
