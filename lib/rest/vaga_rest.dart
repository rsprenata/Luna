import 'package:luna/model/vaga.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/rest/api.dart';
import 'package:http/http.dart' as http;

class VagaRest{
  Future<List<Vaga>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "vaga/"));
    if (response.statusCode == 200) {
      return Vaga.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os vagas.');
    }
  }
  Future<List<Vaga>> buscarTodosByEmpresa(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "vaga/empresa/$id"));
    if (response.statusCode == 200) {
      return Vaga.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os vagas.');
    }
  }
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

  Future<Vaga> inserir(Vaga vaga) async {
    final http.Response response =
        await http.post(Uri.http(API.endpoint, 'vaga/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: vaga.toJson());
    if (response.statusCode == 200) {
      return Vaga.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo vaga.');
    }
  }

  Future<bool> verificarCandidatura(int idVaga, int idArtista) async {
    final http.Response response = await http.get(Uri.http(API.endpoint, 'vaga/verificarCandidatura/$idVaga/$idArtista'));
    
    if (response.statusCode == 200) {
      return response.body.toLowerCase() == 'true';
    } else {
      throw Exception('Erro ao verificar candidatura: ${response.statusCode}');
    }
  }


  /*Future<void> remover(int id) async {
    final http.Response response = await http
        .delete(Uri.http(API.endpoint, '/vaga/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro removendo vaga: $id.');
    }
  }*/
/*
  Future<vaga?> buscarPorCpf(String cpf) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/clientes/cpf/$cpf'));
    if (response.statusCode == 200) {
      return response.body == "" ? null : vaga.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando vaga: $cpf [code: ${response.statusCode}]');
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
  }*/
}
