import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/vaga/manter_vaga.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ListarVagasPage extends StatefulWidget {
  static const String routeName = '/vagas';

  const ListarVagasPage({super.key});
  @override
  State<StatefulWidget> createState() => _ListarVagasPageState();
}

class _ListarVagasPageState extends State<ListarVagasPage> {
  List<Vaga> _lista = <Vaga>[];
  List<Vaga> _listaFiltrada = <Vaga>[];
  String _filtro = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshList();
  }

  void _refreshList() async {
    List<Vaga> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
      _listaFiltrada =
          tempList; // Inicialmente a lista filtrada é igual à lista completa
    });
  }

  Future<List<Vaga>> _obterTodos() async {
    List<Vaga> tempLista = <Vaga>[];
    try {
      final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;
      VagaRepository repository = VagaRepository();
      tempLista = await repository.buscarTodosByEmpresa(usuario!.id!);
    } catch (exception) {
      showError(context, "Erro obtendo lista de Vagas", exception.toString());
    }
    return tempLista;
  }

  void _filtrarLista(String valor) {
    setState(() {
      _filtro = valor;
      _listaFiltrada = _lista
          .where(
              (vaga) => vaga.nome.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Trabalhos"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      endDrawer: authProvider.isLoggedIn ? const AppDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Filtrar',
                  border: OutlineInputBorder(),
                ),
                onChanged: _filtrarLista,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: _listaFiltrada.map((vaga) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vaga.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text('Valor: ${vaga.valor}',
                              style: const TextStyle(fontSize: 18)),
                          Text('Data: ${vaga.data}',
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                   Navigator.pushNamed(
                                    context,
                                    Routes.manterVaga,
                                    arguments: {"id": vaga.id},
                                  ).then((atualizar) {
                                    if (atualizar != null && atualizar == true) {
                                      _refreshList();
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Editar',
                                    style: TextStyle(fontSize: 18)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.listarCandidaturasEmpresa, arguments: {"id" : vaga.id});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Candidaturas',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final atualizar =
              await Navigator.pushNamed(context, ManterVagaPage.routeName);
          if (atualizar != null && atualizar == true) _refreshList();
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
