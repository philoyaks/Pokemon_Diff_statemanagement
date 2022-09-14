import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/models/pokemon_response_model.dart';
import 'package:pokedex/services/storage/storage_services.dart';

import '../models/api_response_model.dart';

import '../screens/Details_screen/pokemon_details_screen.dart';
import '../services/Repository/pokemon_repository.dart';
import '../widgets/show_error_alert_dialog.dart';

class PokemonController extends GetxController {
  final Repository _repo = Repository();
  final AppStorage _storageService = AppStorage();

  RxList<Pokemon> pokemons = <Pokemon>[].obs;
  RxString nextUrl = ''.obs;
  RxList<Pokemon> favoritePokemons = <Pokemon>[].obs;
  Rx<Pokemon> currentPokemon = Pokemon(id: 0).obs;
  RxBool continuationLoader = false.obs;
  RxBool isLoading = false.obs;
  RxBool isFavorite = false.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (continuationLoader.isFalse) {
          continuationLoader.value = true;
          await loadPokemonResults();
          continuationLoader.value = false;
        }
      }
    });
    super.onInit();
  }
  

  @override
  void onReady() async {
    isLoading.value = true;
    favoritePokemons.value = await _storageService.getSavedPokemon();
    await loadPokemonResults();
    isLoading.value = false;
    super.onReady();
  }

  goToDetailsScreen(Pokemon p) async {
    currentPokemon.value = p;
    isFavorite.value = favoritePokemons.where((e) => e.id == p.id).isNotEmpty;
    Navigator.of(Get.context!)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return PokeMonDetailsScreeen();
    }));
  }

  loadPokemonResults() async {
    ResponseModel res = await _repo.getAllPokemons(
        nextUrl: nextUrl.isEmpty ? null : nextUrl.value);
    if (res.valid!) {
      PokemonResponseModel allPokemon = res.data;
      nextUrl.value = allPokemon.next!;
      for (var pokemon in allPokemon.results!) {
        ResponseModel res = await _repo.getSpecificPokemon(id: pokemon.name);
        if (res.valid!) {
          Pokemon p = res.data;
          pokemons.add(p);
          pokemons.sort((a, b) => a.id!.compareTo(b.id!));
        } else {
          showErrorAlert(
              context: Get.context!, description: res.error!.message);
          break;
        }
      }
    } else {
      showErrorAlert(context: Get.context!, description: res.error!.message);
    }
  }

  addOrRemoveFavoritePokemon(Pokemon pokemon) async {
    if (isFavorite.isFalse) {
      isFavorite.value = true;
      await _storageService.savePokemon(pokemon);
      favoritePokemons.value = await _storageService.getSavedPokemon();
    } else {
      isFavorite.value = false;
      await _storageService.deletePokomon(pokemon);
      favoritePokemons.value = await _storageService.getSavedPokemon();
    }

  }
}
