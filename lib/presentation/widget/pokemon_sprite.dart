import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonSprite extends StatelessWidget {
  final String spriteUrl;
  final double? size;

  const PokemonSprite({super.key, required this.spriteUrl, this.size});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: spriteUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorWidget: (context, url, error) =>
          Icon(Icons.image_not_supported_outlined, size: 50),
    );
  }
}
