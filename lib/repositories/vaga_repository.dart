import 'package:luna/model/vaga.dart';
import 'package:luna/rest/vaga_rest.dart';

class VagaRepository {
  final VagaRest api = VagaRest();
  Future<List<Vaga>> buscarTodos() async {
    return await api.buscarTodos();
  }
}
