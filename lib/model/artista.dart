import 'dart:convert';
import 'dart:ffi';

import 'package:luna/model/usuario.dart';

class Artista extends Usuario {
  String peso;
  String altura;
  String experiencia;
  int? idade;

  Artista({
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
    required this.peso,
    required this.altura,
    required this.experiencia,
    required this.idade
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
  Artista.novo({
    required String nome,
    required String email,
    required String senha,
    required String endereco,
    required String telefone,
    required String bairroEndereco,
    required String numeroEndereco,
    required String cidadeEndereco,
    required int nivel,
    required this.peso,
    required this.altura,
    required this.experiencia,
    required this.idade
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
      'id': id,
      'peso': peso,
      'altura': altura,
      'experiencia': experiencia,
      'nome': nome,
      'email': email,
      'senha': senha,
      'endereco': endereco,
      'telefone': telefone,
      'bairroEndereco': bairroEndereco,
      'numeroEndereco': numeroEndereco,
      'cidadeEndereco': cidadeEndereco,
      'idade': idade
    };
  }

  static Artista fromMap(Map<String, dynamic> map) {
    return Artista(
      id: map['id'],
      email: map['email'],
      nome: map['nome'],
      senha: map['senha'],
      endereco: map['endereco'],
      telefone: map['telefone'],
      bairroEndereco: map['bairroEndereco'],
      numeroEndereco: map['numeroEndereco'],
      cidadeEndereco: map['cidadeEndereco'],
      peso: map['peso'],
      altura: map['altura'],
      experiencia: map['experiencia'],
      idade: map['idade'],
      nivel: map['nivel']
    );
  }

  static List<Artista> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Artista.fromMap(maps[i]);
    });
  }

  static Artista fromJson(String j) => Artista.fromMap(jsonDecode(j));
  static List<Artista> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Artista>((map) => Artista.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
