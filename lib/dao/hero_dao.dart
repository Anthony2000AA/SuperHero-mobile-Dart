
import 'package:sqflite/sqflite.dart';
import 'package:superhero_mobile_flutter/database/app_database.dart';
import 'package:superhero_mobile_flutter/models/hero.dart';

class HeroDao{
  //Inset herodao 
  insert(SuperHero superhero) async {
    Database database = await AppDatabase().openDB();
    await database.insert(AppDatabase().tableName, superhero.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Delete herodao
  delete(SuperHero superhero) async {
    Database database = await AppDatabase().openDB();

    await database.delete(
      AppDatabase().tableName,
      where: "id = ?",
      whereArgs: [superhero.id],
    );
  }

  //Get all herodao
  Future<List<SuperHero>> getAll() async {
    Database database = await AppDatabase().openDB();
    final List<Map<String, dynamic>> maps = await database.query(AppDatabase().tableName);

    return List.generate(maps.length, (i) {
      return SuperHero(
        id: maps[i]['id'],
        name: maps[i]['name'],
        fullName: maps[i]['fullName'],
        path: '',
      );
    });
  }

  //is favorite herodao
  Future<bool> isFavorite(SuperHero superhero) async {
    Database database = await AppDatabase().openDB();
    final List<Map<String, dynamic>> maps = await database.query(
      AppDatabase().tableName,
      where: "id = ?",
      whereArgs: [superhero.id],
    );

    return maps.isNotEmpty;
  }
}