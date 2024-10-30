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

class _ListarVagasDisponiveisPageState
    extends State<ListarVagasDisponiveisPage> {
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
          .where(
              (vaga) => vaga.nome.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trabalhos Disponíveis"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
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
              // Adiciona padding ao redor da tabela
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Ajuste conforme necessário
              child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey),
                  verticalInside: BorderSide.none,
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
                children: [
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Título',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Valor',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ..._listaFiltrada.map((vaga) {
                    return TableRow(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.visualizarVaga,
                              arguments: {"id": vaga.id},
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300]!),
                              ),
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8.0),
                            child: Text(
                              vaga.nome,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.visualizarVaga,
                              arguments: {"id": vaga.id},
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8.0),
                            child: Text(
                              vaga.valor.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.visualizarVaga,
                              arguments: {"id": vaga.id},
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8.0),
                            child: Text(
                              vaga.data.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
