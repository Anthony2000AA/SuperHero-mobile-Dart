
import 'dart:convert';
import 'dart:io';

import 'package:superhero_mobile_flutter/models/hero.dart';
import 'package:http/http.dart' as http;

class HeroService{
  final  String baseUrl = 'https://www.superheroapi.com/api.php/10157703717092094/search/';

  Future<List<SuperHero>> getHeroesByName(String name) async{
    final response = await http.get(Uri.parse('$baseUrl$name'));
    if(response.statusCode == HttpStatus.ok){
      final result = jsonDecode(response.body);
      Iterable list = result['results'];
      return list.map((hero) => SuperHero.fromJson(hero)).toList();
    }else{
      throw Exception('Failed to load heroes');
    }
  }
}