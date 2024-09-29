import 'dart:convert';

import 'package:luna/model/usuario.dart';

class Empresa extends Usuario{
  String cnpj;
  String? descricao;

  Empresa({
    required int id,
    required String nome,
    required String email,
    required String senha,
    required String endereco,
    required String telefone,
    required String bairroEndereco,
    required String numeroEndereco,
    required String cidadeEndereco,
    required int nivel,
    required this.cnpj,
    this.descricao,
  }) : super(
          id,
          nome,
          email,
          senha,
          endereco,
          telefone,
          bairroEndereco,
          numeroEndereco,
          cidadeEndereco,
          nivel,
        );

  Empresa.novo({
    required String nome,
    required String email,
    required String senha,
    required String endereco,
    required String telefone,
    required String bairroEndereco,
    required String numeroEndereco,
    required String cidadeEndereco,
    required int nivel,
    required this.cnpj,
    this.descricao,
  }) : super.novo(
          nome,
          email,
          senha,
          endereco,
          telefone,
          bairroEndereco,
          numeroEndereco,
          cidadeEndereco,
          nivel,
        );

  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
      'descricao': descricao
    };
  }

  static Empresa fromMap(Map<String, dynamic> map) {
    return Empresa(
      id: map['id'],
      email: map['email'],
      nome: map['nome'],
      senha: map['senha'],
      endereco: map['endereco'],
      telefone: map['telefone'],
      bairroEndereco: map['bairroEndereco'],
      numeroEndereco: map['numeroEndereco'],
      cidadeEndereco: map['cidadeEndereco'],
      cnpj: map['cnpj'],
      descricao: map['descricao'],
      nivel: map['nivel']
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
