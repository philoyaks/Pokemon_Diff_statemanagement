import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/models/pokemon_model.dart';
import 'package:pokedex/presentation/bloc/pokemon_event.dart';
import 'package:pokedex/presentation/bloc/pokemon_state.dart';
import '../../core/storage_service/storage_services.dart';
import '../../data/remote_datasource/pokemon_repository.dart';
import '../../domain/models/api_response_model.dart';
import '../../domain/models/pokemon_response_model.dart';
import '../screens/Details_screen/pokemon_details_screen.dart';
import '../widgets/show_error_alert_dialog.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  List<Pokemon> _favoritePokemon = [];
  final List<Pokemon> _allPokemons = [];
  final PokemonRepository _pokemonService;
  final AppStorage _storageService = AppStorage();
  String? nextUrl;
  PokemonBloc(this._pokemonService) : super(PokemonInitial()) {
    on<LoadPokemons>((event, emit) async {
      try {
        emit(PokemonLoading());
        await _loadAllPokemons(event.context);
        emit(PokemonLoaded(
            allPokemons: _allPokemons, favoritePokemon: _favoritePokemon));
      } catch (e) {
        emit(PokemonError(e.toString()));
      }
    });

    on<AddOrRemovePokemon>((event, emit) async {
      var currentState = state as PokemonLoaded;
      late bool isfavorite;
      if (!currentState.isfavoritePokemon) {
        isfavorite = true;
        await _storageService.savePokemon(event.pokemon);
      } else {
        isfavorite = false;
        await _storageService.deletePokomon(event.pokemon);
      }
      _favoritePokemon = await _storageService.getSavedPokemon();

      emit(currentState.copyWith(
          favoritePokemon: _favoritePokemon, isfavoritePokemon: isfavorite));
    });

    on<LoadMorePokemon>((event, emit) async {
      var currstate = state as PokemonLoaded;
      emit(currstate.copyWith(showPaginationLoader: true));
      await _loadAllPokemons(event.context);
      emit(PokemonLoaded(
          allPokemons: _allPokemons, favoritePokemon: _favoritePokemon));
    });

    on<GotoDetailsScreen>((event, emit) {
      var currstate = state as PokemonLoaded;
      bool isFavorite = currstate.favoritePokemon!
          .where((e) => e.id == event.pokemon.id)
          .isNotEmpty;

      Navigator.of(event.context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        return const PokeMonDetailsScreeen();
      }));
      emit(currstate.copyWith(
          currentPokemon: event.pokemon, isfavoritePokemon: isFavorite));
    });
  }

  Future<void> _loadAllPokemons(BuildContext context) async {
    _favoritePokemon = await _storageService.getSavedPokemon();
    ResponseModel res = await _pokemonService.getAllPokemons(nextUrl: nextUrl);
    if (res.valid!) {
      PokemonResponseModel allPokemon = res.data;
      nextUrl = allPokemon.next!;
      for (var pokemon in allPokemon.results!) {
        ResponseModel res =
            await _pokemonService.getSpecificPokemon(id: pokemon.name);
        if (res.valid!) {
          Pokemon p = res.data;
          _allPokemons.add(p);
          _allPokemons.sort((a, b) => a.id!.compareTo(b.id!));
        } else {
          showErrorAlert(context: context, description: res.error!.message);
          break;
        }
      }
    } else {
      showErrorAlert(context: context, description: res.error!.message);
    }
  }
}
