class Empresa {
  final String imagem;
  final String categoria;
  final String nome;
  final String descricao;
  final String numero;

  const Empresa({
    required this.imagem,
    required this.categoria,
    required this.nome,
    required this.descricao,
    required this.numero
  });

  factory Empresa.fromJson(dynamic json){
    return Empresa(
      imagem: json['image'] as String,
      categoria: json['category'] as String,
      nome: json['name'] as String,
      descricao: json['description'] as String,
      numero: json['number'] as String,
    );
  }

  @override
  String toString() {
    return 'Empresa{imagem: $imagem, categoria: $categoria, nome: $nome, descricao: $descricao, numero: $numero}';
  }
}

class All {
  List<Empresa> empresas;

  All({required this.empresas});

  factory All.fromJson(List<dynamic> json) {
    List<Empresa> empresas = [];
    empresas = json.map((r) => Empresa.fromJson(r)).toList();
    return All(empresas: empresas);
  }
}