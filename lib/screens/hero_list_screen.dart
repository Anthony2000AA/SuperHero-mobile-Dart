import 'package:flutter/material.dart';
import 'package:superhero_mobile_flutter/dao/hero_dao.dart';
import 'package:superhero_mobile_flutter/models/hero.dart';
import 'package:superhero_mobile_flutter/screens/hero_detail_screen.dart';
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
        preferredSize: const Size.fromHeight(150),
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "Search for your favorite hero",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search hero',
                    prefixIcon: const Icon(Icons.search),
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
    final apiResponse = await _heroService.getHeroesByName(widget.query);
    setState(() {
      _heroes = apiResponse.results;//apiResponse.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.isEmpty) {
      return Container(); 
    }
    //return FutureBuilder<List<SuperHero>>(
    return FutureBuilder<ApiResponse>(
      future: _heroService.getHeroesByName(widget.query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());

        } else if (snapshot.hasError) {
          return Center(child: Text('El super heroe ${widget.query} no existe'));

        } else {
          _heroes = snapshot.data!.results;

          return ListView.builder(
            itemCount: _heroes.length,
            itemBuilder: (context, index) {
              return SuperHeroItem(hero: _heroes[index]);
            },
          );
        }
      },
    );
  }
}








class SuperHeroItem extends StatefulWidget {
  const SuperHeroItem({super.key, required this.hero});

  final SuperHero hero;

  @override
  State<SuperHeroItem> createState() => _SuperHeroItemState();
}

class _SuperHeroItemState extends State<SuperHeroItem> {

  bool _isFavorite = false;

  final HeroDao _heroDao = HeroDao();

  initialize() async {
    _isFavorite = await _heroDao.isFavorite(widget.hero);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeroDetailScreen(hero: widget.hero),
          ),
        );
      },
      child: Card(
                  child: ListTile(
                    title: Text(widget.hero.name),
                    subtitle: Text(widget.hero.fullName),
                    leading: Image.network(widget.hero.path),
                    trailing: IconButton(
                      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: _isFavorite ? Colors.red : Colors.grey,
                      onPressed: () => {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        }),
                       _isFavorite ? HeroDao().insert(widget.hero) : HeroDao().delete(widget.hero)
                      },
                     
                     ),
                  ),
                ),
    );
  }
}