import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:superhero_mobile_flutter/models/hero.dart';
import 'package:superhero_mobile_flutter/services/hero_service.dart';

class HeroListScreen extends StatefulWidget {
  const HeroListScreen({Key? key});

  @override
  State<HeroListScreen> createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  final _searchController = TextEditingController();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Search for your favorite hero",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search hero',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: HeroList(query: _name),
    );
  }
}

class HeroList extends StatefulWidget {
  const HeroList({Key? key, required this.query});
  final String query;

  @override
  State<HeroList> createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {
  List<SuperHero> _heroes = [];
  final _heroService = HeroService();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (widget.query.isEmpty) {
      return;
    }
    final heroes = await _heroService.getHeroesByName(widget.query);
    setState(() {
      _heroes = heroes;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.isEmpty) {
      return Container(); 
    }
    return FutureBuilder<List<SuperHero>>(
      future: _heroService.getHeroesByName(widget.query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('El super heroe ${widget.query} no existe'));
        } else {
          _heroes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: _heroes.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(_heroes[index].name),
                  subtitle: Text(_heroes[index].fullName),
                  leading: Image.network(_heroes[index].path),
                ),
              );
            },
          );
        }
      },
    );
  }
}


jl
