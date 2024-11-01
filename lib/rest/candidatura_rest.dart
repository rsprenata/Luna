import 'package:luna/model/candidatura.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/rest/api.dart';
import 'package:http/http.dart' as http;

class CandidaturaRest{
  Future<List<Candidatura>> buscarCandidaturasArtista(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "candidatura/artista/$id"));
    if (response.statusCode == 200) {
      return Candidatura.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos as candidaturas do artista.');
    }
  }

  Future<List<Candidatura>> buscarCandidaturasEmpresa(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "candidatura/empresa/$id"));
    if (response.statusCode == 200) {
      return Candidatura.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos as candidaturas do empresa.');
    }
  }

  Future<List<Candidatura>> buscarCandidaturasVaga(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "candidatura/vaga/$id"));
    if (response.statusCode == 200) {
      return Candidatura.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos as candidaturas do vaga.');
    }
  }
  /*
  Future<Vaga> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/vaga/$id'));
    if (response.statusCode == 200) {
      return Vaga.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando vaga: $id [code: ${response.statusCode}]');
    }
  }

  Future<Vaga> alterar(Vaga vaga) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'vaga/${vaga.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: vaga.toJson(),
    );
    if (response.statusCode == 200) {
      return vaga;
    } else {
      throw Exception('Erro alterando vaga ${vaga.id}.');
    }
  }
*/
  Future<Candidatura> inserir(Candidatura candidatura) async {
    print(candidatura.toJson());
    final http.Response response =
        await http.post(Uri.http(API.endpoint, 'candidatura/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: candidatura.toJson());
    if (response.statusCode == 200) {
      return Candidatura.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo candidatura.');
    }
  }

 Future<void> aprovarCandidatura(int id) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'candidatura/aprovar/$id')
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro aprovando.');
    }
  }

 Future<void> reprovarCandidatura(int id) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'candidatura/reprovar/$id')
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro aprovando.');
    }
  }


/* Future<Vaga> alterar(Vaga vaga) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'vaga/${vaga.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: vaga.toJson(),
    );
    if (response.statusCode == 200) {
      return vaga;
    } else {
      throw Exception('Erro alterando vaga ${vaga.id}.');
    }
  }atusCode}]');
    }
  }

  Future<List<vaga>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "clientes/"));
    if (response.statusCode == 200) {
      return vaga.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os clientes.');
    }
  }

  

  Future<vaga> remover(int id) async {
    final http.Response response = await http
        .delete(Uri.http(API.endpoint, '/clientes/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      return vaga.fromJson(response.body);
    } else {
      throw Exception('Erro removendo vaga: $id.');
    }
  }*/
}
