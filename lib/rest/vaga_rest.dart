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
}
