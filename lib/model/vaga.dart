import 'dart:convert';
import 'dart:ffi';


class Vaga {
  int? id;
  String nome;
  String descricao;
  String valor;
  String data;
  int qtdVagas;

  Vaga(this.id, this.nome, this.descricao, this.valor, this.data, this.qtdVagas);
  Vaga.novo(this.nome, this.descricao, this.valor, this.data, this.qtdVagas);
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'valor': valor,
      'data': data,
      'qtdVagas': qtdVagas,
    };
  }

  static Vaga fromMap(Map<String, dynamic> map) {
    return Vaga(
      map['id'],
      map['nome'],
      map['descricao'],
      map['valor'],
      map['data'],
      map['qtdVagas'],
    );
  }

  static List<Vaga> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Vaga.fromMap(maps[i]);
    });
  }

  static Vaga fromJson(String j) => Vaga.fromMap(jsonDecode(j));
  static List<Vaga> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Vaga>((map) => Vaga.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
