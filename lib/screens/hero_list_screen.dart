import 'package:flutter/material.dart';
import 'package:superhero_mobile_flutter/models/hero.dart';
import 'package:superhero_mobile_flutter/services/hero_service.dart';

class HeroListScreen extends StatelessWidget {
  const HeroListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SuperHero List'),
      ),
      body: HeroList()
    );
  }
}

class HeroList extends StatefulWidget {
  const HeroList({super.key});

  @override
  State<HeroList> createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {

  List<SuperHero> _heroes=[];
  final _heroService = HeroService();


  initialize() async{
    final heroes = await _heroService.getHeroesByName('robin');
    setState(() {
      _heroes = heroes;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
   
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _heroes.length,
      itemBuilder:(context, index){
        return Card(
          child: ListTile(
            title: Text(_heroes[index].name),
            subtitle: Text(_heroes[index].fullName),
            leading: Image.network(_heroes[index].path),
          ),
        );
      }

    );
  }
}