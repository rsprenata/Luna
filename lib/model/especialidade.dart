import 'dart:convert';
import 'dart:ffi';


class Especialidade {
  int? id;
  String descricao;

  Especialidade(this.id, this.descricao);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  static Especialidade fromMap(Map<String, dynamic> map) {
    return Especialidade(
      map['id'],
      map['descricao'],
    );
  }

  static List<Especialidade> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Especialidade.fromMap(maps[i]);
    });
  }

  static Especialidade fromJson(String j) => Especialidade.fromMap(jsonDecode(j));
  static List<Especialidade> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Especialidade>((map) => Especialidade.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Especialidade && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
