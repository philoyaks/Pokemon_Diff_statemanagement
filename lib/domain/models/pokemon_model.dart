// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_utils.dart';

part 'pokemon_model.g.dart';

@HiveType(typeId: 0)
class Pokemon {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? height;

  @HiveField(2)
  String? name;

  @HiveField(3)
  List<Stats>? stats;

  @HiveField(4)
  List<Types>? types;

  @HiveField(5)
  int? weight;

  @HiveField(6)
  String? imageUrl;

  //Other Parameters
  String get typesToString => types!.map((e) => e.types).join(', ');
  String get bmI => (weight! / (height! * height!)).toStringAsFixed(2);
  int get avgPower {
    num sum = 0;
    for (var item in stats!) {
      sum += item.stat;
    }
    return sum ~/ stats!.length;
  }

  // Picks random colors based on the first type
  MaterialColor get bgColor =>
      AppColors().getPokemonColor(types![0].types.toLowerCase());

  Pokemon(
      {this.id,
      this.height,
      this.name,
      this.stats,
      this.types,
      this.weight,
      this.imageUrl});

  Pokemon copyWith({
    int? id,
    int? height,
    String? name,
    List<Stats>? stats,
    List<Types>? types,
    int? weight,
    String? imageUrl,
  }) {
    return Pokemon(
        id: id ?? this.id,
        height: height ?? this.height,
        name: name ?? this.name,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        weight: weight ?? this.weight,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int,
      height: map['height'] as int,
      name: capitalize(map['name']),
      imageUrl: map['sprites']['other']['official-artwork']['front_default']
          as String,
      stats: List<Stats>.from(
        (map['stats'] as List<dynamic>).map<Stats>(
          (x) => Stats.fromMap(x as Map<String, dynamic>),
        ),
      ),
      types: List<Types>.from(
        (map['types'] as List<dynamic>).map<Types>(
          (x) => Types.fromMap(x as Map<String, dynamic>),
        ),
      ),
      weight: map['weight'] as int,
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pokemon(id: $id, height: $height, name: $name, stats: $stats, types: $types, weight: $weight, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant Pokemon other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.height == height &&
        other.name == name &&
        listEquals(other.stats, stats) &&
        listEquals(other.types, types) &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        height.hashCode ^
        name.hashCode ^
        stats.hashCode ^
        types.hashCode ^
        weight.hashCode;
  }
}

@HiveType(typeId: 1)
class Stats {
  @HiveField(0)
  int stat;

  @HiveField(1)
  String name;

  Stats({
    required this.stat,
    required this.name,
  });

  Stats copyWith({
    int? stat,
    String? name,
  }) {
    return Stats(
      stat: stat ?? this.stat,
      name: name ?? this.name,
    );
  }

  factory Stats.fromMap(Map<String, dynamic> map) {
    int stat = map['base_stat'];
    String name = map['stat']['name'];
    if (name == "hp") {
      return Stats(stat: stat, name: "HP ");
    } else if (name == "attack") {
      return Stats(stat: stat, name: "Attack");
    } else if (name == "defense") {
      return Stats(stat: stat, name: "Defense");
    } else if (name == "special-attack") {
      return Stats(stat: stat, name: "Special Attack");
    } else if (name == "special-defense") {
      return Stats(stat: stat, name: "Special Defense");
    } else if (name == "speed") {
      return Stats(stat: stat, name: "Speed");
    } else {
      return Stats(stat: stat, name: name);
    }
  }
}

@HiveType(typeId: 2)
class Types {
  @HiveField(0)
  String types;
  Types({
    required this.types,
  });

  Types copyWith({
    String? types,
  }) {
    return Types(
      types: types ?? this.types,
    );
  }

  factory Types.fromMap(Map<String, dynamic> map) {
    String type = map['type']['name'];
    return Types(types: type[0].toUpperCase() + type.substring(1));
  }
}
