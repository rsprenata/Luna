import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/empresa.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/repositories/empresa_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditarUsuarioEmpresaPage extends StatefulWidget {
  static const String routeName = '/perfil/editar';

  const EditarUsuarioEmpresaPage({super.key});
  @override
  _EditarUsuarioEmpresaPageState createState() => _EditarUsuarioEmpresaPageState();
}

class _EditarUsuarioEmpresaPageState extends State<EditarUsuarioEmpresaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _senhaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cnpjController = TextEditingController();

  int _id = 0;
  Usuario? _usuario;
  Empresa? _empresa;
  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _obterUsuario() async {
    try {
      //var maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
      UsuarioRepository repository = UsuarioRepository();
      _usuario = await repository.buscar(_id);
      _nomeController.text = _usuario!.nome;
    } catch (exception) {
      showError(context, "Erro recuperando usuario", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
    _empresa!.nome = _nomeController.text;
    _empresa!.endereco = _enderecoController.text;
    _empresa!.bairroEndereco = _bairroController.text;
    _empresa!.cidadeEndereco = _cidadeController.text;
    _empresa!.numeroEndereco = _numeroController.text;
    _empresa!.cnpj = _cnpjController.text;
    _empresa!.senha = _enderecoController.text;
    _empresa!.email = _emailController.text;
    _empresa!.telefone = _telefoneController.text;

    try {
      EmpresaRepository repository = EmpresaRepository();
      await repository.alterar(_empresa!);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empresa editada com sucesso.')));
      Navigator.pop(context);
    } catch (exception) {
      showError(context, "Erro editando empresa", exception.toString());
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
            title: Text('Nome da empresa'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Nome da empresa',
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
            title: Text('CNPJ da empresa'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  CNPJ da empresa',
                  ),
                  controller: _cnpjController,
                ),),
              ),
            ],
          ),
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Email'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Email',
                  ),
                  controller: _emailController,
                ),),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Endereço'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Endereço',
                  ),
                  controller: _enderecoController,
                ),),
              ),
            ],
          ),
            
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Número'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Número',
                  ),
                  controller: _numeroController,
                ),),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child:ListTile(
            title: Text('Bairro'),
            subtitle:  TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Bairro',
                  ),
                  controller: _bairroController,
                ),),
              ),
            ],
          ),
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Cidade'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Cidade',
                  ),
                  controller: _cidadeController,
                ),),
              ),
            ],
          ),
            Row(
            children: [
              Expanded(
                child: ListTile(
            title: Text('Telefone'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Telefone',
                  ),
                  controller: _telefoneController,
                ),),
              ),
            ],
          ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: ListTile(
            title: Text('Senha'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Senha',
                  ),
                  controller: _senhaController,
                ),),
              ),
            ]),
            /*
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _salvar();
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
            ])*/
          ])) // Form
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Map m = ModalRoute.of(context)!.settings.arguments as Map;
    _id = m["id"];
    _obterUsuario();
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Editar Usuario"),
        backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)
      ),
      //drawer: const AppDrawer(),
      body: SingleChildScrollView(
    child:_buildForm(context),
    ));
  }
}
