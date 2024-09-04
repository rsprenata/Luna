import 'dart:convert';
import 'dart:ffi';


class Nivel {
  int? id;
  String descricao;

  Nivel(this.id, this.descricao);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  static Nivel fromMap(Map<String, dynamic> map) {
    return Nivel(
      map['id'],
      map['descricao'],
    );
  }

  static List<Nivel> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Nivel.fromMap(maps[i]);
    });
  }

  static Nivel fromJson(String j) => Nivel.fromMap(jsonDecode(j));
  static List<Nivel> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Nivel>((map) => Nivel.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
