class TechModel {
  final String id;
  final String title;
  final String icon;
  final String image;
  final String category;
  final String tagline;
  final String difficulty;
  final String color;
  final String description;
  final String working;
  final String applications;
  final String advantages;
  final String disadvantages;
  final String futureScope;

  const TechModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.image,
    required this.category,
    required this.tagline,
    required this.difficulty,
    required this.color,
    required this.description,
    required this.working,
    required this.applications,
    required this.advantages,
    required this.disadvantages,
    required this.futureScope,
  });

  factory TechModel.fromJson(Map<String, dynamic> json) {
    return TechModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      image: json['image'],
      category: json['category'],
      tagline: json['tagline'],
      difficulty: json['difficulty'],
      color: json['color'],
      description: json['description'],
      working: json['working'],
      applications: json['applications'],
      advantages: json['advantages'],
      disadvantages: json['disadvantages'],
      futureScope: json['futureScope'],
    );
  }
}
