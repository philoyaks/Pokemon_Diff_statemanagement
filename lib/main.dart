import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/constants/app_theme.dart';
import 'package:pokedex/data/remote_datasource/pokemon_repository.dart';
import 'package:pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex/presentation/bloc/pokemon_event.dart';
import 'package:pokedex/presentation/screens/Home_screen/home_screen.dart';
import 'package:pokedex/core/storage_service/storage_services.dart';

void main() async {
  await AppStorage().initializeHiveParameters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PokemonBloc(PokemonRepository())..add(LoadPokemons(context)),
          child: Container(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemeData.appThemeData,
        home: const MyHomePage(),
      ),
    );
  }
}
