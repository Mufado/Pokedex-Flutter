import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/data/repository/pokemons_repository.dart';
import 'package:pokedex_app/presentation/widget/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
    final pokemonsRepo = context.read<PokemonsRepository>();

    return Scaffold(
      appBar: AppBar(title: Text('Pokemons'), centerTitle: true),
      body: FutureBuilder(
        future: pokemonsRepo.getAllPokemons(offset: 0, limit: 20),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: List.generate(
                snapshot.data!.length,
                (index) => Container(
                  padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                  child: PokemonCard(pokemonData: snapshot.data![index]),
                ),
              ),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
