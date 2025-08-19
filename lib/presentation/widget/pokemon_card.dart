import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';

class PokemonCard extends StatelessWidget {
  static const _size = 100.0;

  final PokemonData pokemonData;

  const PokemonCard({super.key, required this.pokemonData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
            child: SizedBox(
              width: _size,
              height: _size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: _getPokemonSpriteUrl(pokemonUrl: pokemonData.url),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
            child: Center(
              child: Text(
                pokemonData.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPokemonSpriteUrl({required String pokemonUrl}) {
    const baseImageURL =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';
    final pokemonUri = Uri.parse(pokemonUrl);
    final pokemonId =
        pokemonUri.pathSegments[pokemonUri.pathSegments.length - 2];

    return '$baseImageURL/$pokemonId.png';
  }
}
