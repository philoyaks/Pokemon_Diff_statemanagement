abstract class RepoInterface {
  /// [GET]: Gets Pokemon Details from Repository, requires [id]
  getSpecificPokemon({String? id});

  /// [GET]: Gets List of  Pokemon from Repository
  getAllPokemons({String? nextUrl});
}
