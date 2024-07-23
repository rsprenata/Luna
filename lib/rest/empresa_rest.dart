import 'package:luna/model/empresa.dart';
import 'package:luna/rest/api.dart';
import 'package:http/http.dart' as http;

class EmpresaRest{
  Future<Empresa> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/empresa/$id'));
    if (response.statusCode == 200) {
      return Empresa.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando empresa: $id [code: ${response.statusCode}]');
    }
  }

  Future<Empresa> alterar(Empresa empresa) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'empresas/${empresa.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: empresa.toJson(),
    );
    if (response.statusCode == 200) {
      return empresa;
    } else {
      throw Exception('Erro alterando empresa ${empresa.id}.');
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

  Future<Cliente> inserir(Cliente cliente) async {
    final http.Response response =
        await http.post(Uri.http(API.endpoint, 'clientes/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: cliente.toJson());
    if (response.statusCode == 200) {
      return Cliente.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo cliente.');
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
