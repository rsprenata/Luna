import 'package:luna/model/candidatura.dart';
import 'package:luna/rest/candidatura_rest.dart';

class CandidaturaRepository {
  final CandidaturaRest api = CandidaturaRest();
  
  Future<List<Candidatura>> buscarCandidaturasArtista(int _artistaId) async {
    return await api.buscarCandidaturasArtista(_artistaId);
  }

  Future<List<Candidatura>> buscarCandidaturasEmpresa(int empresaId) async {
    return await api.buscarCandidaturasEmpresa(empresaId);
  }
  
  Future<List<Candidatura>> buscarCandidaturasVaga(int vagaId) async {
    return await api.buscarCandidaturasVaga(vagaId);
  }
  
  Future<void> aprovarCandidatura(int id) async {
    await api.aprovarCandidatura(id);
  }
  
  Future<void> reprovarCandidatura(int id) async {
    await api.reprovarCandidatura(id);
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
