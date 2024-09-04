import 'package:luna/model/candidatura.dart';
import 'package:luna/rest/candidatura_rest.dart';

class CandidaturaRepository {
  final CandidaturaRest api = CandidaturaRest();
  
  Future<List<Candidatura>> buscarCandidaturasArtista(int _artistaId) async {
    return await api.buscarCandidaturasArtista(_artistaId);
  }
  /*
  Future<Vaga> buscar(int id) async {
    return await api.buscar(id);
  }
  Future<Vaga> alterar(Vaga artista) async {
    return await api.alterar(artista);
  }*/
  Future<Candidatura> inserir(Candidatura candidatura) async {
    return await api.inserir(candidatura);
  }
/*
  Future<Usuario?> buscarPorCpf(String cpf) async {
    return await api.buscarPorCpf(cpf);
  }

  Future<List<Usuario>> buscarTodos() async {
    return await api.buscarTodos();
  }

  

  Future<Usuario> remover(int id) async {
    return await api.remover(id);
  }*/
}
