import 'dart:convert';

import 'package:luna/model/usuario.dart';

class Artista extends Usuario {
  String peso;
  String altura;
  String experiencia;

  Artista(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, this.peso, this.altura, this.experiencia) : super(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco);
  Artista.novo(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco, this.peso, this.altura, this.experiencia) : super(id, nome, email, senha, endereco, telefone, bairroEndereco, numeroEndereco, cidadeEndereco);

  Map<String, dynamic> toMap() {
    return {
      'peso': peso,
      'altura': altura,
      'experiencia': experiencia,
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
      map['peso'],
      map['altura'],
      map['experiencia']
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
