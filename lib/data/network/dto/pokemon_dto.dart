class PokemonDTO {
  int id;
  List<PokemonAbility> abilities;
  int height;
  String name;
  PokemonSprites sprites;
  List<PokemonType> types;
  int weight;

  PokemonDTO({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
    required this.sprites,
    required this.types,
    required this.weight,
  });
}

class PokemonAbility {
  Ability ability;

  PokemonAbility({required this.ability});
}

class Ability {
  String name;

  Ability({required this.name});
}

class PokemonSprites {
  String frontDefault;

  PokemonSprites({required this.frontDefault});
}

class PokemonType {
  Type type;

  PokemonType({required this.type});
}

class Type {
  String name;

  Type({required this.name});
}
