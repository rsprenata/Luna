import 'package:flutter/material.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/vaga/manter_vaga.dart';
import 'package:provider/provider.dart';

class ListarVagasPage extends StatefulWidget {
  static const String routeName = '/vagas';

  const ListarVagasPage({super.key});
  @override
  State<StatefulWidget> createState() => _ListarVagasPageState();
}

class _ListarVagasPageState extends State<ListarVagasPage> {
  List<Vaga> _lista = <Vaga>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshList() async {
    List<Vaga> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
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

  /*void _removerVaga(Vaga Vaga) async {
    try {
      PedidoRepository pedidoRepository = PedidoRepository();
      List<Pedido> pedidos = await pedidoRepository.listarPorCpf(Vaga.cpf);

      if (pedidos.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Não é possível excluir esse Vaga pois ele tem pedidos.')));
      } else {
        VagaRepository repository = VagaRepository();
        await repository.remover(Vaga.id!).then((value) {
          _refreshList();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Vaga ${Vaga.id} removido com sucesso.')));
        });
      }
    } catch (exception) {
      showError(context, "Erro removendo Vaga", exception.toString());
    }
  }*/

  /*void _showItem(BuildContext context, int index) {
    Vaga Vaga = _lista[index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(Vaga.nome),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.fingerprint),
                    Text("CPF: ${Vaga.cpf}")
                  ]),
                  Row(children: [
                    const Icon(Icons.person),
                    Text("Nome: ${Vaga.nome}")
                  ]),
                  Row(children: [
                    const Icon(Icons.badge),
                    Text("Sobrenome: ${Vaga.sobrenome}")
                  ]),
                ],
              ),
              actions: [
                TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }*/

  /*void _editItem(BuildContext context, int index) {
    Vaga b = _lista[index];
    Navigator.pushNamed(
      context,
      EditarVagaPage.routeName,
      arguments: <String, int>{"id": b.id!},
    ).then((value) => _refreshList());
  }*/

  /*void _removeItem(BuildContext context, int index) {
    Vaga b = _lista[index];
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Remover Vaga"),
              content: Text("Gostaria realmente de remover ${b.nome}?"),
              actions: [
                TextButton(
                  child: const Text("Não"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Sim"),
                  onPressed: () {
                    _removerVaga(b);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }*/

  ListTile _buildItem(BuildContext context, int index) {
    Vaga v = _lista[index];

    return ListTile(
      leading: const Icon(Icons.work),
      title: Text('${v.nome}'),
      //subtitle: Text(b.cpf),
      onTap: () {
        //_showItem(context, index);
      },
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 'edit', child: Text('Editar')),
            //const PopupMenuItem(value: 'delete', child: Text('Remover')),
            const PopupMenuItem(
                value: 'candidaturas', child: Text('Ver Candidaturas*'))
          ];
        },
        onSelected: (String value) async {
          if (value == 'edit') {
            //_editItem(context, index);.
            final atualizar = await Navigator.pushNamed(
                context, Routes.manterVaga,
                arguments: {"id": v.id});
            if (atualizar != null && atualizar == true) _refreshList();
          } else {
            Navigator.pushNamed(context, Routes.listarCandidaturasEmpresa);
            //_removeItem(context, index);
          }
        },
      ),
    );
  }

  /*void _removeItem(BuildContext context, int index) {
    Vaga v = _lista[index];
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Remover Cliente"),
              content: Text("Gostaria realmente de remover ${b.nome}?"),
              actions: [
                TextButton(
                  child: const Text("Não"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Sim"),
                  onPressed: () {
                    _removerVaga(v);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _removerVaga(Vaga vaga) async {
    try {
      VagaRepository vagaRepository = VagaRepository();
      await vagaRepository.remover(vaga.id!).then((value) {
          _refreshList();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Cliente ${cliente.id} removido com sucesso.')));
        });


      List<Pedido> pedidos = await vagaRepository.listarPorCpf(cliente.cpf);

      if (pedidos.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Não é possível excluir esse cliente pois ele tem pedidos.')));
      } else {
        ClienteRepository repository = ClienteRepository();
        await repository.remover(cliente.id!).then((value) {
          _refreshList();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Cliente ${cliente.id} removido com sucesso.')));
        });
      }
    } catch (exception) {
      showError(context, "Erro removendo cliente", exception.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Listagem de Vagas"),
      ),
      //drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: _lista.length,
        itemBuilder: _buildItem,
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.VagaInsert)
            .then((value) => _refreshList()),
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
