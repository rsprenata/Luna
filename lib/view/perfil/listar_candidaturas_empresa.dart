import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/candidatura.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/candidatura_repository.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ListarCandidaturasEmpresaPage extends StatefulWidget {
  static const String routeName = '/candidatura/candidaturasEmpresa';
  final int? id;

  const ListarCandidaturasEmpresaPage({super.key, this.id});

  @override
  State<StatefulWidget> createState() => _ListarCandidaturasEmpresaPageState();
}

class _ListarCandidaturasEmpresaPageState extends State<ListarCandidaturasEmpresaPage> {
  int? _idVaga;
  late Future<Vaga> _vagaFuture;
  List<Candidatura> _lista = <Candidatura>[];

  @override
  void initState() {
    super.initState();
    _idVaga = widget.id;
    if (_idVaga != null) {
      _vagaFuture = _obterVaga();
      _refreshList(_idVaga!);
    }
  }

  Future<Vaga> _obterVaga() async {
    try {
      VagaRepository repository = VagaRepository();
      return await repository.buscar(_idVaga!);
    } catch (exception) {
      showError(context, "Erro recuperando vaga", exception.toString());
      Navigator.pop(context);
      rethrow;
    }
  }

  void _refreshList(int idVaga) async {
    List<Candidatura> tempList = await _obterTodos(idVaga);
    setState(() {
      _lista = tempList;
    });
  }

  Future<List<Candidatura>> _obterTodos(int idVaga) async {
    try {
      CandidaturaRepository repository = CandidaturaRepository();
      return await repository.buscarCandidaturasVaga(idVaga);
    } catch (exception) {
      showError(context, "Erro obtendo lista de Vagas", exception.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Candidaturas"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Vaga>(
        future: _vagaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar a vaga.'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Vaga não encontrada.'));
          }

          Vaga _vaga = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${_vaga.nome}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Valor: ${_vaga.valor}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Data: ${_vaga.data}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Quantidade de Vagas: ${_vaga.qtdVagas}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20.0), // Espaço antes da lista de candidatos
                Expanded(
                  child: _lista.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma candidatura.',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _lista.length,
                          itemBuilder: (context, index) {
                            return _buildCard(context, index);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    Candidatura c = _lista[index];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artista: ${c.artista.nome}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Nível: ${c.vaga.especialidade.descricao}', style: const TextStyle(fontSize: 18)),
            Text('Status: ${c.status.descricao}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.manterPerfilArtista, arguments: <String, dynamic>{
                      "id": c.artista.id!,
                      "isReadOnly": true
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Visualizar Artista', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            if (c.status.id == 3) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _confirmarAcao(context, c, false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Reprovar', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () async {
                      _confirmarAcao(context, c, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Aprovar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  void _confirmarAcao(BuildContext context, Candidatura c, bool aprovar) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: Text(
            aprovar
                ? 'Tem certeza que deseja APROVAR esta candidatura?'
                : 'Tem certeza que deseja REPROVAR esta candidatura?', style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () async {
                await _processarCandidatura(c, aprovar);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processarCandidatura(Candidatura c, bool aprovar) async {
    try {
      CandidaturaRepository repository = CandidaturaRepository();
      if (aprovar) {
        await repository.aprovarCandidatura(c.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Aprovado com sucesso.'),
            behavior: SnackBarBehavior.floating));
      } else {
        await repository.reprovarCandidatura(c.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Reprovado com sucesso.'),
            behavior: SnackBarBehavior.floating));
      }

      _refreshList(_idVaga!);
    } catch (exception) {
      showError(context, "Erro ao processar candidatura", exception.toString());
    }
  }
}
