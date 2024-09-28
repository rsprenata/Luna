import 'dart:convert';
import 'dart:ffi';

import 'package:luna/model/usuario.dart';

class Artista extends Usuario {
  String peso;
  String altura;
  String experiencia;
  int? idade;

  Artista(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, nivel, this.peso, this.altura, this.experiencia, this.idade) : super(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, nivel);
  Artista.novo(nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, nivel, this.peso, this.altura, this.experiencia, this.idade) : super.novo(nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, nivel);

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
      'nivel': nivel,
      'idade': idade
    };
  }

  static Artista fromMap(Map<String, dynamic> map) {
    return Artista(
      map['id'],
      map['email'],
      map['nome'],
      map['senha'],
      map['endereco'],
      map['telefone'],
      map['bairroEndereco'],
      map['numeroEndereco'],
      map['cidadeEndereco'],
      map['nivel'],
      map['peso'],
      map['altura'],
      map['experiencia'],
      map['idade']
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
