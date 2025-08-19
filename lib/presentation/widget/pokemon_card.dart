import 'package:flutter/material.dart';
import 'package:pokedex_app/domain/entity/pokemon.dart';
import 'package:pokedex_app/presentation/widget/pokemon_sprite.dart';

class PokemonCard extends StatelessWidget {
  static const _size = 100.0;

  final PokemonData pokemonData;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.pokemonData,
    required this.onTap,
  });

  String _getPokemonSpriteUrl({required String pokemonUrl}) {
    const baseImageURL =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';
    final pokemonUri = Uri.parse(pokemonUrl);
    final pokemonId =
        pokemonUri.pathSegments[pokemonUri.pathSegments.length - 2];

    return '$baseImageURL/$pokemonId.png';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                width: _size,
                height: _size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: PokemonSprite(
                    spriteUrl: _getPokemonSpriteUrl(
                      pokemonUrl: pokemonData.url,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  pokemonData.name.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
