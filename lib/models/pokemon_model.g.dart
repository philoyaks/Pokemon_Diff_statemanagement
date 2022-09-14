// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as int?,
      height: fields[1] as int?,
      name: fields[2] as String?,
      stats: (fields[3] as List?)?.cast<Stats>(),
      types: (fields[4] as List?)?.cast<Types>(),
      weight: fields[5] as int?,
      imageUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.stats)
      ..writeByte(4)
      ..write(obj.types)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatsAdapter extends TypeAdapter<Stats> {
  @override
  final int typeId = 1;

  @override
  Stats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stats(
      stat: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stats obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stat)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypesAdapter extends TypeAdapter<Types> {
  @override
  final int typeId = 2;

  @override
  Types read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Types(
      types: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Types obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
