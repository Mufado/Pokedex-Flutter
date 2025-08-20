import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/application/pokemon_details_cubit.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/presentation/widget/pokemon_sprite.dart';
import 'package:pokedex_app/presentation/widget/type_tags.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonData pokemonData;

  const PokemonDetailsPage({super.key, required this.pokemonData});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late final PokemonDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PokemonDetailsCubit>();
    _cubit.loadPokemonDetail(widget.pokemonData.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pokemonData.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder(
        bloc: _cubit,
        builder: (context, state) {
          if (state is PokemonDetailsLoaded) {
            return _buildDetails(state.pokemon);
          } else if (state is PokemonDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Error: ${state.message}')],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDetails(Pokemon pokemon) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PokemonSprite(spriteUrl: pokemon.spriteUrl ?? '', size: 200),
                const SizedBox(height: 16),
                Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '#${pokemon.id.toString().padLeft(4, '0')}',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: pokemon.types
                      .map((type) => TypeTags(type: type))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem(
                            'Height',
                            '${(pokemon.height / 10).toStringAsFixed(1)} m',
                            Icons.height,
                          ),
                        ),
                        Expanded(
                          child: _buildInfoItem(
                            'Weight',
                            '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                            Icons.monitor_weight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Abilities',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...pokemon.abilities.map(
                            (ability) => Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                ability.toUpperCase(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
