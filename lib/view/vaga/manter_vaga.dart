import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/nivel.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/repositories/artista_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ManterVagaPage extends StatefulWidget {
  static const String routeName = '/vaga/inserir';

  const ManterVagaPage({super.key});
  @override
  _ManterVagaPageState createState() => _ManterVagaPageState();
}

class _ManterVagaPageState extends State<ManterVagaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  final _qtdVagasController = TextEditingController();

  int? _id;
  bool isArtista = false;
  late Vaga _vaga;
  @override
  void dispose() {
    _nomeController.dispose();
    _dataController.dispose();
    _descricaoController.dispose();
    _valorController.dispose();
    _qtdVagasController.dispose();
    super.dispose();
  }

  void _obterVaga() async {
    try {
      //var maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
      VagaRepository repository = VagaRepository();
      _vaga = await repository.buscar(_id!);
      _nomeController.text = _vaga.nome;
      _dataController.text = _vaga.data;
      _descricaoController.text = _vaga.descricao;
      _qtdVagasController.text = _vaga.qtdVagas.toString();
      _valorController.text = _vaga.valor;
    } catch (exception) {
      showError(context, "Erro recuperando vaga", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
    _vaga = Vaga.novo(_nomeController.text, _descricaoController.text, 
    _valorController.text, _dataController.text,int.parse(_qtdVagasController.text), Nivel(1, "Ator"), _vaga.empresa);
    

    try {
      VagaRepository repository = VagaRepository();
      await repository.inserir(_vaga!);
      _nomeController.clear();
      _dataController.clear();
      _descricaoController.clear();
      _valorController.clear();
      _qtdVagasController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vaga inserida com sucesso.')));
      Navigator.pop(context, true);
    } catch (exception) {
      showError(context, "Erro inserindo vaga", exception.toString());
    }
  }

  void _alterar() async {
    _vaga.data = _dataController.text;
    _vaga.descricao = _descricaoController.text;
    _vaga.nome = _nomeController.text;
    _vaga.qtdVagas = int.parse(_qtdVagasController.text);
    _vaga.valor = _valorController.text;

    try {
      VagaRepository repository = VagaRepository();
      await repository.alterar(_vaga);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vaga editada com sucesso.')));
      Navigator.pop(context, true);
    } catch (exception) {
      showError(context, "Erro editando vaga", exception.toString());
    }
  }

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Título da vaga'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Título da vaga',
                  ),
                  controller: _nomeController,
                ),),
              ),
            ],
          ),
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Descrição'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Descrição',
                  ),
                  controller: _descricaoController,
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Valor'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Valor',
                  ),
                  controller: _valorController,
                ),),
              ),
            ],
          ),
            
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Data'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Data',
                  ),
                  controller: _dataController,
                ),),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child:ListTile(
            title: Text('Quantidade de vagas'),
            subtitle:  TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Quantidade de vagas',
                  ),
                  controller: _qtdVagasController,
                ),),
              ),
            ],
          ),
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if(_id != null) {
                      _alterar();
                    } else {
                      _salvar();
                    }
                  }
                },
                child: const Text('Salvar')
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ])
          ])) // Form
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Map? m = ModalRoute.of(context)!.settings.arguments as Map?;
    if(m != null && m["id"] != null) {
      _id = m["id"];
    _obterVaga();
    }
  
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Inserir nova vaga"),
        backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)
      ),
      //drawer: const AppDrawer(),
      body: SingleChildScrollView(
    child:_buildForm(context),
    ));
  }
}




