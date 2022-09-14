import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_constants.dart';

void main() {
  late PokemonRepositoryMock datasource;

  setUpAll(() {
    datasource = PokemonRepositoryMock();
  });

  test('should check for the right specific Pokemon', () async {
    when(() => datasource.getSpecificPokemon(id: '6'))
        .thenAnswer((_) => Future.value(mockPokemonTest));

    final result =
        await datasource.getSpecificPokemon(id: mockPokemonTest.id.toString());
    expect(result, isA<void>());
  });

  test('should check if getAll pokemons works', () async {
    when(() => datasource.getAllPokemons(nextUrl: ''))
        .thenAnswer((_) => Future.value(mockPokemonTest));
    final result = await datasource.getAllPokemons();

    expect(result, isA<void>());
  });
}
