import 'dart:convert';

class Usuario {
  int? id;
  String email;
  String senha;
  String endereco;
  String bairroEndereco;
  String numeroEndereco;
  String cidadeEndereco;
  String telefone;
  String nome;
  int? nivel;

  Usuario(this.id,
  this.nome,
  this.email,
  this.senha,
  this.endereco,
  this.telefone,
  this.bairroEndereco,
  this.numeroEndereco,
  this.cidadeEndereco,
  this.nivel);
  Usuario.novo(this.nome,
  this.email,
  this.senha,
  this.endereco,
  this.telefone,
  this.bairroEndereco,
  this.numeroEndereco,
  this.cidadeEndereco,
  this.nivel);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': email,
      'nome': nome,
      'senha': senha,
      'endereco': endereco,
      'telefone': telefone,
      'bairroEndereco': bairroEndereco,
      'numeroEndereco': numeroEndereco,
      'cidadeEndereco': cidadeEndereco,
      'nivel': nivel
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    return Usuario(
      map['id'],
      map['email'],
      map['nome'],
      map['senha'],
      map['endereco'],
      map['telefone'],
      map['bairroEndereco'],
      map['numeroEndereco'],
      map['cidadeEndereco'],
      map['nivel']
    );
  }

  static List<Usuario> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  static Usuario fromJson(String j) => Usuario.fromMap(jsonDecode(j));
  static List<Usuario> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Usuario>((map) => Usuario.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
