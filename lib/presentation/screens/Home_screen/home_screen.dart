import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/presentation/screens/Home_screen/tabar_widgets/all_pokemon_tab_widgets.dart';
import 'package:pokedex/presentation/screens/Home_screen/tabar_widgets/favorite_pokemon_tab_widgets.dart';

import '../../../core/constants/app_colors.dart';
import '../../bloc/pokemon_bloc.dart';
import '../../bloc/pokemon_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/pokemon_logo.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "Pokedex",
                style: TextStyle(
                  color: AppColors.textColorgrey,
                  fontSize: 24,
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  const Text(
                    "All Pokemons",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Favorites"),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff3558cd),
                        ),
                        child: Center(
                          child: BlocBuilder<PokemonBloc, PokemonState>(
                            builder: (context, state) {
                              return Text(
                                (state is PokemonLoaded)
                                    ? state.favoritePokemon!.length.toString()
                                    : '0',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllPokemon(),
                  FavoritePokemon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
