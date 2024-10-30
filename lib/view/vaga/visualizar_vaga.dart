import 'dart:ffi';
import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/candidatura.dart';
import 'package:luna/model/status.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/artista_repository.dart';
import 'package:luna/repositories/candidatura_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisualizarVagaPage extends StatefulWidget {
  final int? id;

  static const String routeName = '/vaga/visualizar';

  const VisualizarVagaPage({super.key, this.id});

  @override
  State<VisualizarVagaPage> createState() => _VisualizarVagaPageState();
}

class _VisualizarVagaPageState extends State<VisualizarVagaPage> {
  int? _id;
  late Future<Vaga> _vagaFuture;
  bool _isCandidatureExists = false;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    if (_id != null) {
      _vagaFuture = _obterVaga();
      _checkCandidature();
    }
  }

  Future<Vaga> _obterVaga() async {
    try {
      VagaRepository repository = VagaRepository();
      return await repository.buscar(_id!);
    } catch (exception) {
      showError(context, "Erro recuperando vaga", exception.toString());
      Navigator.pop(context);
      throw exception;
    }
  }

  Future<void> _checkCandidature() async {
    final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;
    try {
      VagaRepository repository = VagaRepository();
      _isCandidatureExists =
          await repository.verificarCandidatura(_id!, usuario!.id!);
    } catch (exception) {
      showError(context, "Erro verificando candidatura", exception.toString());
    }
  }

  void _candidatar(Vaga vaga) async {
    final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;
    final Artista _artista = Artista(
        id: usuario!.id!,
        nome: "nome",
        email: "email",
        senha: "senha",
        endereco: "endereco",
        telefone: "telefone",
        bairroEndereco: "bairroEndereco",
        numeroEndereco: "numeroEndereco",
        cidadeEndereco: "cidadeEndereco",
        nivel: 2,
        peso: "peso",
        altura: "altura",
        experiencia: "experiencia",
        idade: 22);

    Candidatura _candidatura =
        Candidatura.novo(vaga, _artista, Status(3, "Em análise"));

    try {
      CandidaturaRepository repository = CandidaturaRepository();
      await repository.inserir(_candidatura);

      setState(() {
        _isCandidatureExists = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Candidatura feita com sucesso.')));
      Navigator.pop(context, true);
    } catch (exception) {
      showError(context, "Erro ao candidatar-se", exception.toString());
    }
  }

  Widget _buildForm(BuildContext context, Vaga vaga) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Título da vaga',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      vaga.nome,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Descrição',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      vaga.descricao,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Valor',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      vaga.valor,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Data',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      vaga.data,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Vagas',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      vaga.qtdVagas.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (_isCandidatureExists)
              const Center(child: Text(
                'Você já se candidatou a essa vaga!',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),)
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _candidatar(vaga);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Candidatar-se',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Visualizar vaga"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Vaga>(
        future: _vagaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Nenhuma vaga encontrada"));
          } else {
            final vaga = snapshot.data!;
            return _buildForm(context, vaga);
          }
        },
      ),
    );
  }
}
