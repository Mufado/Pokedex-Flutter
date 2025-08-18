class Pokemon {
  const Pokemon({
    required int id,
    required String name,
    required String sprite,
    required int height,
    required int weight,
    required List<String> abilities,
    required List<String> types,
  });
}

class PokemonData {
  const PokemonData({required String name, required String url});
}
