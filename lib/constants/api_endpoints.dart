class ApiEnpoints {
  static const String baseUrl = "https://pokeapi.co/api/v2/";

  static String getPokemon({int start = 0, int limit = 20}) =>
      'pokemon?offset=$start&limit=$limit';
  static String getPokemonDetails({required String id}) => 'pokemon/$id';
}
