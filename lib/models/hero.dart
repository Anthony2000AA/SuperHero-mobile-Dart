


class ApiResponse{
  final String response;
  final String resultsFor;
  final List<SuperHero> results;

  ApiResponse({required this.response, required this.resultsFor, required this.results});

  ApiResponse.fromJson(Map<String, dynamic> json)
   :  response= json['response'],
     resultsFor= json['results-for'],
     results= (json['results'] as List).map((e) => SuperHero.fromJson(e)).toList();
}


class SuperHero{
  final String id;
  final String name;
  final String fullName;
  final String path;
  final PoweStats powerstats;

  SuperHero({required this.id, required this.name, required this.fullName, required this.path, required this.powerstats});

  SuperHero.fromJson(Map<String, dynamic> json)
   :  id= json['id'],
     name= json['name'],
     fullName= json['biography']['full-name'],//asi para acceder a la propiedad de un objeto dentro de otro objeto
     path= json['image']['url'],
      powerstats= PoweStats.fromJson(json['powerstats']);


   

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'fullName': fullName,
      'path': path
    };
  }


}


class FavoriteHero{
  final String id;
  final String name;
  final String fullName;
  final String path;

  FavoriteHero({required this.id, required this.name, required this.fullName, required this.path});

  FavoriteHero.fromMap(Map<String, dynamic> map)
   :  id= map['id'],
     name= map['name'],
     fullName= map['fullName'],
     path= map['path'];
  

}


class PoweStats{
  final double intelligence;
  final double strength;
  final double speed;
  final double durability;
  final double power;
  final double combat;

  PoweStats({required this.intelligence, required this.strength, required this.speed, required this.durability, required this.power, required this.combat});

  PoweStats.fromJson(Map<String, dynamic> json)
   :  intelligence= double.parse(json['intelligence'] != "null" ? json['intelligence'] : '0'),
      strength= double.parse(json['strength'] != "null" ? json['strength'] : '0'),
      speed= double.parse(json['speed'] != "null" ? json['speed'] : '0'),
      durability= double.parse(json['durability'] != "null" ? json['durability'] : '0'),
      power= double.parse(json['power'] != "null" ? json['power'] : '0'),
      combat= double.parse(json['combat'] != "null" ? json['combat'] : '0');
  
}