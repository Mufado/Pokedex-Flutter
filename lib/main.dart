import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/data/network/client/api_client.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/presentation/list/pokemon_list_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(baseUrl: 'https://pokeapi.co/api/v2/');
    final repository = PokemonsRepository(apiClient: apiClient);

    return MaterialApp(
      title: 'Pokemons',
      home: MultiBlocProvider(
        providers: [
          RepositoryProvider(create: (_) => repository)
        ],
        child: PokemonListPage(),
      ));
  }
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokédex',
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
            ),
            SizedBox(height: 20),
            Expanded(child: PokemonList()),
          ],
        ),
      ),
    );
  }
}

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _controller = ScrollController();
  final items = List.generate(20, (index) => index);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !isLoading) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    setState(() => isLoading = true);

    await Future.delayed(Duration(seconds: 2));
    final newItems = List.generate(10, (index) => items.length + index);

    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: items.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Card(elevation: 2, child: SizedBox(height: 400)),
        );
      },
    );
  }
}
