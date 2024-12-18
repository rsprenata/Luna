import 'package:luna/model/vaga.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/rest/artista_rest.dart';
import 'package:luna/rest/vaga_rest.dart';

class VagaRepository {
  final VagaRest api = VagaRest();
  Future<List<Vaga>> buscarTodos() async {
    return await api.buscarTodos();
  }
  Future<List<Vaga>> buscarTodosByEmpresa(int id) async {
    return await api.buscarTodosByEmpresa(id);
  }
  Future<Vaga> buscar(int id) async {
    return await api.buscar(id);
  }
  Future<Vaga> alterar(Vaga artista) async {
    return await api.alterar(artista);
  }
  Future<Vaga> inserir(Vaga artista) async {
    return await api.inserir(artista);
  }

  Future<bool> verificarCandidatura(int idVaga, int idArtista) async {
    return await api.verificarCandidatura(idVaga, idArtista);
  }
  /*Future<Vaga> remover(int id) async {
    return await api.remover(id);
  }*/
/*
  Future<Usuario?> buscarPorCpf(String cpf) async {
    return await api.buscarPorCpf(cpf);
  }

  Future<List<Usuario>> buscarTodos() async {
    return await api.buscarTodos();
  }

  

  */
}
