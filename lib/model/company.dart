class Company {
  final String image;
  final String category;
  final String name;
  final String description;
  final String number;

  const Company({
    required this.image,
    required this.category,
    required this.name,
    required this.description,
    required this.number
  });

  factory Company.fromJson(dynamic json){
    return Company(
      image: json['image'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      number: json['number'] as String,
    );
  }

  @override
  String toString() {
    return 'Empresa{imagem: $image, categoria: $category, nome: $name, descricao: $description, numero: $number}';
  }
}

class All {
  List<Company> companies;

  All({required this.companies});

  factory All.fromJson(List<dynamic> json) {
    List<Company> companies = [];
    companies = json.map((r) => Company.fromJson(r)).toList();
    return All(companies: companies);
  }
}