import 'dart:convert';
import 'dart:ffi';

import 'package:luna/model/artista.dart';
import 'package:luna/model/status.dart';
import 'package:luna/model/vaga.dart';


class Candidatura {
  int? id;
  Vaga vaga;
  Artista artista;
  Status status;

  Candidatura(this.id, this.vaga, this.artista, this.status);
  Candidatura.novo(this.vaga, this.artista, this.status);
  Map<String, dynamic> toMap() {
    return {
      'vaga': vaga.toMap(),
      'artista': artista.toMap(),
      'status': status.toMap(),
    };
  }

  static Candidatura fromMap(Map<String, dynamic> map) {
    return Candidatura(
      map['id'],
      Vaga.fromMap(map['vaga']),
      Artista.fromMap(map['artista']),
      Status.fromMap(map['status']),
    );
  }

  static List<Candidatura> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Candidatura.fromMap(maps[i]);
    });
  }

  static Candidatura fromJson(String j) => Candidatura.fromMap(jsonDecode(j));
  static List<Candidatura> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Candidatura>((map) => Candidatura.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
