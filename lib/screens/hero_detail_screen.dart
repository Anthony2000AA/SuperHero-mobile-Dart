
import 'package:flutter/material.dart';
import 'package:superhero_mobile_flutter/models/hero.dart';
import 'package:superhero_mobile_flutter/widgets/hero_stat_slider.dart';

class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key, required this.hero});

  final SuperHero hero;

  @override
  Widget build(BuildContext context) {

    final witdh = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(hero.path, width: witdh, height: witdh * 1.5, fit: BoxFit.cover),
            Text(hero.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(hero.fullName, style: const TextStyle(fontSize: 18)),
            ExpansionTile(
              title: const Text("Powerstats"),
              children: [
                HeroStatSlider(statName: "Intelligence", statValue: hero.powerstats.intelligence),
                HeroStatSlider(statName: "Strength", statValue: hero.powerstats.strength),
                HeroStatSlider(statName: "Speed", statValue: hero.powerstats.speed),
                HeroStatSlider(statName: "Durability", statValue: hero.powerstats.durability),
                HeroStatSlider(statName: "Power", statValue: hero.powerstats.power),
                HeroStatSlider(statName: "Combat", statValue: hero.powerstats.combat),

              
              ],
              ),
          ],
          ),
      )
    );
  }
}