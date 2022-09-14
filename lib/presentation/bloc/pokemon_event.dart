// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/pokemon_model.dart';

abstract class PokemonEvent extends Equatable {}

class LoadPokemons extends PokemonEvent {
  final BuildContext context;
  LoadPokemons(
    this.context,
  );
  @override
  List<Object?> get props => [context];
}

class AddOrRemovePokemon extends PokemonEvent {
  final Pokemon pokemon;
  AddOrRemovePokemon({
    required this.pokemon,
  });
  @override
  List<Object?> get props => [pokemon];
}

class LoadMorePokemon extends PokemonEvent {
  final BuildContext context;
  LoadMorePokemon(
    this.context,
  );

  @override
  List<Object?> get props => [context];
}

class GotoDetailsScreen extends PokemonEvent {
  final BuildContext context;
  final Pokemon pokemon;
  GotoDetailsScreen({required this.context, required this.pokemon});

  @override
  List<Object?> get props => [context];
}
