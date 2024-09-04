import 'dart:convert';
import 'dart:ffi';


class Status {
  int? id;
  String descricao;

  Status(this.id, this.descricao);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  static Status fromMap(Map<String, dynamic> map) {
    return Status(
      map['id'],
      map['descricao'],
    );
  }

  static List<Status> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Status.fromMap(maps[i]);
    });
  }

  static Status fromJson(String j) => Status.fromMap(jsonDecode(j));
  static List<Status> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Status>((map) => Status.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
