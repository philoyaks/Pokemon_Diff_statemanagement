import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xffe8e8e8);
  static const Color primaryColor = Color(0xff3558CD);
  static const Color errorColor = Colors.red;

  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;

  //Text Colors
  static const Color textColorgrey = Color(0xff161933);

  getStatusColor({int? value}) {
    double val = value! / 100;
    return val <= 0.4
        ? const Color(0xffCD2873)
        : val > 0.4 && val < 1.0
            ? const Color(0xffEEC218)
            : Colors.green;
  }

  //Gets Pokemon Based On types
  getPokemonColor(String type) {
    switch (type) {
      case 'grass':
        return Colors.green;
      case 'bug':
        return Colors.brown;
      case 'fairy':
        return Colors.indigo;
      case 'electric':
        return Colors.yellow;
      case 'dragon':
        return Colors.deepOrange;
      case 'dark':
        return Colors.grey;
      case 'ground':
        return Colors.brown;
      case 'ice':
        return Colors.blue;
      case 'rock':
        return Colors.lime;
      case 'fire':
        return Colors.red;
      case 'fighting':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'psychic':
        return Colors.amber;
      case 'poison':
        return Colors.red;
      default:
        return Colors.indigo;
    }
  }
}
