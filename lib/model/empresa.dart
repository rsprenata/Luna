import 'dart:convert';

import 'package:luna/model/usuario.dart';

class Empresa extends Usuario{
  String cnpj;

  Empresa(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, this.cnpj) : super(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco);
  Empresa.novo(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, this.cnpj) : super(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco);

  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
    };
  }

  static Empresa fromMap(Map<String, dynamic> map) {
    return Empresa(
      map['id'],
      map['email'],
      map['nome'],
      map['senha'],
      map['endereco'],
      map['telefone'],
      map['bairroEndereco'],
      map['numeroEndereco'],
      map['cidadeEndereco'],
      map['cnpj'],
    );
  }

  static List<Empresa> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Empresa.fromMap(maps[i]);
    });
  }

  static Empresa fromJson(String j) => Empresa.fromMap(jsonDecode(j));
  static List<Empresa> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Empresa>((map) => Empresa.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
