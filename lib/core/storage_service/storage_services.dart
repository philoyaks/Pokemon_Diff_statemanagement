import 'package:hive_flutter/adapters.dart';

import '../../domain/models/pokemon_model.dart';

class AppStorage {
  initializeHiveParameters() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(StatsAdapter());
    Hive.registerAdapter(TypesAdapter());
  }

  static const String hiveBoxname = 'pokedex';

  getSavedPokemon() async {
    var box = await Hive.openBox<Pokemon>(hiveBoxname);

    return box.values.toList();
  }

  savePokemon(Pokemon pokemon) async {
    var box = await Hive.openBox<Pokemon>(hiveBoxname);
    box.add(pokemon);
  }

  deletePokomon(Pokemon pokemon) async {
    var box = await Hive.openBox<Pokemon>(hiveBoxname);
    final Map<dynamic, Pokemon> pokemonMap = box.toMap();
    dynamic desiredKey;
    pokemonMap.forEach((key, value) {
      if (value.id == pokemon.id) {
        desiredKey = key;
      }
    });
    box.delete(desiredKey);
  }
}

