import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/candidatura.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/repositories/candidatura_repository.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/vaga/manter_vaga.dart';

class ListarCandidaturasEmpresaPage extends StatefulWidget {
  static const String routeName = '/candidatura/candidaturasEmpresa';

  const ListarCandidaturasEmpresaPage({super.key});
  @override
  State<StatefulWidget> createState() => _ListarCandidaturasEmpresaPageState();
}

class _ListarCandidaturasEmpresaPageState extends State<ListarCandidaturasEmpresaPage> {
  List<Candidatura> _lista = <Candidatura>[];
  int _empresaId = 18;
  
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  @override
  void dispose() {
    super.dispose();
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
      tempLista = await repository.buscarCandidaturasEmpresa(_empresaId);
    } catch (exception) {
      showError(
          context, "Erro obtendo lista de Vagas", exception.toString());
    }
    return tempLista;
  }


  ListTile _buildItem(BuildContext context, int index) {
    Candidatura c = _lista[index];

    return ListTile(
      leading: const Icon(Icons.work),
      title: Text('${c.vaga.descricao}'),
      //subtitle: Text(b.cpf),
      onTap: () {
        //_showItem(context, index);
      },
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 'visualizar', child: Text('Visualizar'))
          ];
        },
        onSelected: (String value) async {
          if (value == 'visualizar') {
            //_editItem(context, index);.
            final visualizar = await Navigator.pushNamed(context, Routes.visualizarVaga, arguments: {"id" : c.id});
            if(visualizar != null && visualizar == true) _refreshList();
          } else {
            //_removeItem(context, index);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Listagem de Vagas"),
      ),
      //drawer: const AppDrawer(),
      body: Padding(padding: EdgeInsets.all(10),child: 
        Table(children: _criarLinhas()/*, border: TableBorder.symmetric()*/)
      )
      /*ListView.builder(
        itemCount: _lista.length,
        itemBuilder: _buildItem,
      ),*/
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.VagaInsert)
            .then((value) => _refreshList()),
        child: const Icon(Icons.add),
      ),*/
    );
  }
  List<TableRow> _criarLinhas() {
    List<TableRow> rows = [];
    rows.add(const TableRow(children: [
      Text("Vaga", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Nível", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Status", style: TextStyle(fontWeight: FontWeight.bold))]));

      for(var c in _lista) {
        rows.add(TableRow(children: [
      Text(c.vaga.nome),
      Text(c.vaga.nivel.descricao),
      Text(c.status.descricao)]));
      }

      return rows;
  }
}
