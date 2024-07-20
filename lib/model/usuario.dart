import 'dart:convert';

class Usuario {
  int? id;
  String login;
  String senha;
  String endereco;
  String telefone;
  String nome;

  Usuario(this.id, this.nome, this.login, this.senha, this.endereco, this.telefone);
  Usuario.novo(this.nome, this.login, this.senha, this.endereco, this.telefone);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'nome': nome,
      'senha': senha,
      'endereco': endereco,
      'telefone': telefone
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    return Usuario(
      map['id'],
      map['login'],
      map['nome'],
      map['senha'],
      map['endereco'],
      map['telefone']
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
