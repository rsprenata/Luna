import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';

class ListarVagasDisponiveisPage extends StatefulWidget {
  static const String routeName = '/vagas/disponiveis';

  const ListarVagasDisponiveisPage({super.key});

  @override
  State<StatefulWidget> createState() => _ListarVagasDisponiveisPageState();
}

class _ListarVagasDisponiveisPageState extends State<ListarVagasDisponiveisPage> {
  List<Vaga> _lista = <Vaga>[];
  List<Vaga> _listaFiltrada = <Vaga>[];
  String _filtro = '';

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() async {
    List<Vaga> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
      _listaFiltrada = tempList;
    });
  }

  Future<List<Vaga>> _obterTodos() async {
    List<Vaga> tempLista = <Vaga>[];
    try {
      VagaRepository repository = VagaRepository();
      tempLista = await repository.buscarTodos();
    } catch (exception) {
      showError(context, "Erro obtendo lista de Vagas", exception.toString());
    }
    return tempLista;
  }

  void _filtrarLista(String valor) {
    setState(() {
      _filtro = valor;
      _listaFiltrada = _lista
          .where((vaga) => vaga.nome.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: const Text("Trabalhos Disponíveis"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),*/
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
                          Text('Valor: ${vaga.valor}', style: const TextStyle(fontSize: 18)),
                          Text('Data: ${vaga.data}', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.visualizarVaga,
                                    arguments: {"id": vaga.id},
                                  );
                                },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.black,
                      ),
                                child: const Text('Visualizar', style: TextStyle(fontSize: 18)),
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
    );
  }
}
