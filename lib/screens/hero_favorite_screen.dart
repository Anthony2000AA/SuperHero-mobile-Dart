import 'package:flutter/material.dart';
import 'package:superhero_mobile_flutter/dao/hero_dao.dart';

class HeroFavoriteScreen extends StatefulWidget {
  const HeroFavoriteScreen({super.key});

  

  @override
  State<HeroFavoriteScreen> createState() => _HeroFavoriteScreenState();
}

class _HeroFavoriteScreenState extends State<HeroFavoriteScreen> {

  List _favorites = [];


  initialize() async{
    _favorites = await HeroDao().getAll();

    if(mounted){
      setState(() {
      _favorites = _favorites;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_favorites[index].name),
            subtitle: Text(_favorites[index].fullName),
            leading: Image.network(_favorites[index].path),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async{
                await HeroDao().deleteById(_favorites[index].id);
                initialize();
              },
            ),
          );
        },
      ),
    );
  }
}