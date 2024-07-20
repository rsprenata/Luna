import 'package:luna/model/usuario.dart';
import 'package:luna/rest/usuario_rest.dart';
import 'package:luna/model/usuario.dart';

class UsuarioRepository {
  final UsuarioRest api = UsuarioRest();
  Future<Usuario> buscar(int id) async {
    return await api.buscar(id);
  }
/*
  Future<Usuario?> buscarPorCpf(String cpf) async {
    return await api.buscarPorCpf(cpf);
  }

  Future<List<Usuario>> buscarTodos() async {
    return await api.buscarTodos();
  }

  Future<Usuario> inserir(Usuario usuario) async {
    return await api.inserir(usuario);
  }

  Future<Usuario> alterar(Usuario usuario) async {
    return await api.alterar(usuario);
  }

  Future<Usuario> remover(int id) async {
    return await api.remover(id);
  }*/
}
