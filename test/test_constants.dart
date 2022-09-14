import 'package:mocktail/mocktail.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/models/pokemon_response_model.dart';
import 'package:pokedex/services/Repository/pokemon_repo_interface.dart';

Pokemon mockPokemonTest = Pokemon(
    id: 6,
    height: 10,
    weight: 30,
    name: 'Bartizarr',
    types: [Types(types: 'Poison')]);

PokemonResponseModel testPokemonResponseModel = PokemonResponseModel(
    next: 'https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20',
    previous: 'null',
    results: [
      Result(name: 'Bukator', url: "https://pokeapi.co/api/v2/pokemon/1/")
    ]);

class PokemonRepositoryMock extends Mock implements RepoInterface {}
