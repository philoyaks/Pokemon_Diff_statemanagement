import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/core/constants/api_endpoints.dart';
import 'package:pokedex/core/Repository/api_interceptors.dart';
import 'package:pokedex/domain/repository/pokemon_repository.dart';

import '../../domain/models/api_response_model.dart';
import '../../domain/models/pokemon_model.dart';
import '../../domain/models/pokemon_response_model.dart';

class PokemonRepository implements PokemonRepoInterface {
  BackendService apiService = BackendService(Dio());

  @override
  getAllPokemons({String? nextUrl}) async {
    try {
      final Response res =
          await apiService.dio.get(nextUrl ?? ApiEnpoints.getPokemon());

      final int statusCode = res.statusCode ?? 000;
      if (statusCode >= 200 && statusCode <= 300) {
        return ResponseModel<PokemonResponseModel>(
            valid: true,
            message: res.statusMessage,
            data: PokemonResponseModel.fromJson(res.data));
      }
    } on DioError catch (e) {
      var res = apiService.handleError(e);
      debugPrint(
          'An Error Ocurred while making an Api Call: [INFO] $res'); // Debug print statement for the error
      return ResponseModel<PokemonResponseModel>(
          valid: false,
          message: res!.data["message"],
          error: ErrorModel.fromJson(res.data));
    }
  }

  @override
  getSpecificPokemon({String? id}) async {
    try {
      final Response res =
          await apiService.dio.get(ApiEnpoints.getPokemonDetails(id: id!));
      final int statusCode = res.statusCode ?? 000;
      if (statusCode >= 200 && statusCode <= 300) {
        return ResponseModel<Pokemon>(
            valid: true,
            message: res.statusMessage,
            data: Pokemon.fromMap(res.data));
      }
    } on DioError catch (e) {
      var res = apiService.handleError(e);
      debugPrint('An Error Ocurred while making an Api Call: [INFO] $res');
      return ResponseModel<Pokemon>(
          valid: false,
          message: res!.data["message"],
          error: ErrorModel.fromJson(res.data));
    }
  }
}
