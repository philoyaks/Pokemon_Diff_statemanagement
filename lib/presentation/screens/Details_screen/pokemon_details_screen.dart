import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/constants/app_utils.dart';
import 'package:pokedex/presentation/screens/Details_screen/widgets/brief_detail.dart';
import 'package:pokedex/presentation/screens/Details_screen/widgets/pokemon_detail_botton.dart';
import 'package:pokedex/presentation/screens/Details_screen/widgets/information_banner.dart';
import 'package:pokedex/presentation/screens/Details_screen/widgets/status_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/models/pokemon_model.dart';
import '../../bloc/pokemon_bloc.dart';
import '../../bloc/pokemon_state.dart';

class PokeMonDetailsScreeen extends StatelessWidget {
  const PokeMonDetailsScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        final pokemon = (state as PokemonLoaded).currentPokemon ?? Pokemon();

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: getExpanedHeight(context),
                backgroundColor: pokemon.bgColor[50],
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: AppColors.blackColor,
                  onPressed: () => Navigator.pop(context),
                ),
                pinned: true,
                flexibleSpace: const FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    collapseMode: CollapseMode.pin,
                    background: InfomationBannerDisplay()),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: AppColors.whiteColor,
                          child: Row(
                            children: [
                              specificDetailsWidget(
                                  label: 'Height',
                                  value: pokemon.height.toString()),
                              specificDetailsWidget(
                                  label: 'Weight',
                                  value: pokemon.weight.toString()),
                              specificDetailsWidget(
                                  label: 'BMI', value: pokemon.bmI.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          color: AppColors.whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 16),
                                child: Text(
                                  "Base stats",
                                  style: TextStyle(
                                    color: AppColors.textColorgrey,
                                    fontSize: 16,
                                    fontFamily: "Noto Sans",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Column(
                                children: List.generate(
                                  pokemon.stats!.length,
                                  (index) => statusIndicator(
                                      label: pokemon.stats![index].name,
                                      value: pokemon.stats![index].stat),
                                ),
                              ),
                              statusIndicator(
                                  label: 'Avg Power', value: pokemon.avgPower),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
          floatingActionButton: PokemonDetailsButton(pokemon: pokemon),
        );
      },
    );
  }
}
