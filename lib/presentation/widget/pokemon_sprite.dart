import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonSprite extends StatelessWidget {
  final String spriteUrl;
  final double? size;

  const PokemonSprite({super.key, required this.spriteUrl, this.size});

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: spriteUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    } catch (e) {
      return Icon(Icons.image_not_supported, size: 50);
    }
  }
}
