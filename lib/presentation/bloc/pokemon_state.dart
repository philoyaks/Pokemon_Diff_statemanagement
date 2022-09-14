// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/models/pokemon_model.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon>? favoritePokemon;
  final List<Pokemon>? allPokemons;
  final Pokemon? currentPokemon;
  final bool isfavoritePokemon;
  final bool showPaginationLoader;
  PokemonLoaded(
      {this.currentPokemon,
      this.favoritePokemon,
      this.allPokemons,
      this.isfavoritePokemon = false,
      this.showPaginationLoader = false});

  PokemonLoaded copyWith({
    List<Pokemon>? favoritePokemon,
    List<Pokemon>? allPokemons,
    Pokemon? currentPokemon,
    bool? isfavoritePokemon,
    bool? showPaginationLoader,
  }) {
    return PokemonLoaded(
      favoritePokemon: favoritePokemon ?? this.favoritePokemon,
      allPokemons: allPokemons ?? this.allPokemons,
      currentPokemon: currentPokemon ?? this.currentPokemon,
      isfavoritePokemon: isfavoritePokemon ?? this.isfavoritePokemon,
      showPaginationLoader: showPaginationLoader ?? this.showPaginationLoader,
    );
  }
}

class PokemonError extends PokemonState {
  final String message;
  PokemonError(this.message);
}

class PokemonFavoriesLoaded extends PokemonState {
  final List<Pokemon> favories;

  PokemonFavoriesLoaded(this.favories);
}

class PokemonDetails extends PokemonState {
  final List<Pokemon> favories;

  PokemonDetails(this.favories);
}
