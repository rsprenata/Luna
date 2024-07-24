import 'package:luna/model/artista.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/rest/api.dart';
import 'package:http/http.dart' as http;

class ArtistaRest{
  Future<Artista> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/artista/$id'));
    if (response.statusCode == 200) {
      return Artista.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando usuario: $id [code: ${response.statusCode}]');
    }
  }

  Future<Artista> alterar(Artista artista) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'artista/${artista.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: artista.toJson(),
    );
    if (response.statusCode == 200) {
      return artista;
    } else {
      throw Exception('Erro alterando cliente ${artista.id}.');
    }
  }

  Future<Artista> inserir(Artista artista) async {
    print(artista.toJson());
    final http.Response response =
        await http.post(Uri.http(API.endpoint, 'artista/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: artista.toJson());
    if (response.statusCode == 200) {
      return Artista.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo artista.');
    }
  }
/*
  Future<Cliente?> buscarPorCpf(String cpf) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/clientes/cpf/$cpf'));
    if (response.statusCode == 200) {
      return response.body == "" ? null : Cliente.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando cliente: $cpf [code: ${response.statusCode}]');
    }
  }

  Future<List<Cliente>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "clientes/"));
    if (response.statusCode == 200) {
      return Cliente.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os clientes.');
    }
  }

  

  Future<Cliente> remover(int id) async {
    final http.Response response = await http
        .delete(Uri.http(API.endpoint, '/clientes/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      return Cliente.fromJson(response.body);
    } else {
      throw Exception('Erro removendo cliente: $id.');
    }
  }*/
}
