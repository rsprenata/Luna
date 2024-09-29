import 'package:luna/model/empresa.dart';
import 'package:luna/rest/empresa_rest.dart';

class EmpresaRepository {
  final EmpresaRest api = EmpresaRest();
  Future<Empresa> buscar(int id) async {
    return await api.buscar(id);
  }
  Future<Empresa> alterar(Empresa empresa) async {
    return await api.alterar(empresa);
  }

  Future<Empresa> inserir(Empresa empresa) async {
    return await api.inserir(empresa);
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

  Future<Usuario> remover(int id) async {
    return await api.remover(id);
  }*/
}
