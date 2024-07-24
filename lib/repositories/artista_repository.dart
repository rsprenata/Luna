import 'package:luna/model/artista.dart';
import 'package:luna/rest/artista_rest.dart';

class ArtistaRepository {
  final ArtistaRest api = ArtistaRest();
  Future<Artista> buscar(int id) async {
    return await api.buscar(id);
  }
  Future<Artista> alterar(Artista artista) async {
    return await api.alterar(artista);
  }
  Future<Artista> inserir(Artista artista) async {
    return await api.inserir(artista);
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
