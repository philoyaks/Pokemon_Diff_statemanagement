import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/constants/app_utils.dart';
import 'package:pokedex/controller/pokemon_controller.dart';
import 'package:pokedex/screens/Details_screen/widgets/brief_detail.dart';
import 'package:pokedex/screens/Details_screen/widgets/pokemon_detail_botton.dart';
import 'package:pokedex/screens/Details_screen/widgets/information_banner.dart';
import 'package:pokedex/screens/Details_screen/widgets/status_indicator.dart';
import '../../constants/app_colors.dart';

class PokeMonDetailsScreeen extends StatelessWidget {
  PokeMonDetailsScreeen({Key? key}) : super(key: key);
  final ctr = Get.find<PokemonController>();

  @override
  Widget build(BuildContext context) {
    final pokemon = ctr.currentPokemon.value;
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
              onPressed: () => Get.back(),
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
      floatingActionButton: PokemonDetailsButton(ctr: ctr, pokemon: pokemon),
    );
  }
}
