class SuperHero{
  final String name;
  final String fullName;
  final String path;

  const SuperHero({required this.name, required this.fullName, required this.path});

  factory SuperHero.fromJson(Map<String, dynamic> json){
    return SuperHero(
      name: json['name'],
      fullName: json['biography']['full-name'],
      path: json['image']['url']
    );
  }

}