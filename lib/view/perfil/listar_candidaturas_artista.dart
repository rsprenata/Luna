import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/candidatura.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/candidatura_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:provider/provider.dart';

class ListarCandidaturasArtistaPage extends StatefulWidget {
  static const String routeName = '/candidatura/candidaturasArtista';

  const ListarCandidaturasArtistaPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _ListarCandidaturasArtistaPageState();
}

class _ListarCandidaturasArtistaPageState extends State<ListarCandidaturasArtistaPage> {
  List<Candidatura> _lista = <Candidatura>[];
  List<Candidatura> _listaFiltrada = <Candidatura>[];
  String _filtro = '';

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() async {
    List<Candidatura> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
      _listaFiltrada = tempList; // Inicializa a lista filtrada com todos os itens
    });
  }

  Future<List<Candidatura>> _obterTodos() async {
    List<Candidatura> tempLista = <Candidatura>[];
    try {
      CandidaturaRepository repository = CandidaturaRepository();
      final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;
      
      tempLista = await repository.buscarCandidaturasArtista(usuario!.id!);
    } catch (exception) {
      showError(context, "Erro obtendo lista de Vagas", exception.toString());
    }
    return tempLista;
  }

  void _filtrarLista(String valor) {
    setState(() {
      _filtro = valor;
      _listaFiltrada = _lista
          .where((candidatura) => candidatura.vaga.nome.toLowerCase().contains(valor.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("Minhas candidaturas"),
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
                children: _listaFiltrada.map((candidatura) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidatura.vaga.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text('Valor: ${candidatura.vaga.valor}', style: const TextStyle(fontSize: 18)),
                          Text('Data: ${candidatura.vaga.data}', style: const TextStyle(fontSize: 18)),
                          Text('Especialidade: ${candidatura.vaga.especialidade.descricao}', style: const TextStyle(fontSize: 18)),
                          Text('Status: ${candidatura.status.descricao}', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.visualizarVaga,
                                    arguments: {"id": candidatura.vaga.id},
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
