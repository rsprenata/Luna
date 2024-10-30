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
  
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() async {
    List<Candidatura> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Minhas Candidaturas"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.grey),
              verticalInside: BorderSide.none,
              top: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
            ),
            children: _criarLinhas(),
          ),
        ),
      ),
    );
  }

  List<TableRow> _criarLinhas() {
    List<TableRow> rows = [];
    rows.add(const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Vaga", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Nível", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    ]));

    for (var c in _lista) {
      rows.add(TableRow(children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.visualizarVaga,
              arguments: {"id": c.vaga.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text(c.vaga.nome, style: const TextStyle(fontSize: 16)),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.visualizarVaga,
              arguments: {"id": c.vaga.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text(c.vaga.nivel.descricao, style: const TextStyle(fontSize: 16)),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.visualizarVaga,
              arguments: {"id": c.vaga.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text(c.status.descricao, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ]));
    }

    return rows;
  }
}
