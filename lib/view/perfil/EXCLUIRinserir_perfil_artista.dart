import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/repositories/artista_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditarUsuarioArtistaPage extends StatefulWidget {
  static const String routeName = '/cadastroArtista';

  const EditarUsuarioArtistaPage({super.key});
  @override
  _EditarUsuarioArtistaPageState createState() => _EditarUsuarioArtistaPageState();
}

class _EditarUsuarioArtistaPageState extends State<EditarUsuarioArtistaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _idadeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _experienciaController = TextEditingController();
  final _senhaController = TextEditingController();
  final _alturaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  int _id = 0;
  Usuario? _usuario;
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
    Artista _artista = Artista.novo(
      nome: _nomeController.text, 
      email: _emailController.text, 
      senha: _senhaController.text, 
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      bairroEndereco: _bairroController.text, 
      numeroEndereco: _numeroController.text, 
      cidadeEndereco: _cidadeController.text, 
      peso: _pesoController.text, 
      altura: _alturaController.text, 
      experiencia: _experienciaController.text,
      nivel: 1,
      idade: int.parse(_idadeController.text));

    try {
      ArtistaRepository repository = ArtistaRepository();
      await repository.inserir(_artista!);
    _nomeController.clear();
    _enderecoController.clear();
    _bairroController.clear();
    _cidadeController.clear();
    _numeroController.clear();
    _enderecoController.clear();
    _pesoController.clear();
    _enderecoController.clear();
    _enderecoController.clear();
    _emailController.clear();
    _telefoneController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artista inserido com sucesso.'),
          behavior: SnackBarBehavior.floating));
      Navigator.pop(context);
    } catch (exception) {
      showError(context, "Erro inserindo artista", exception.toString());
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
            title: Text('Nome completo'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Nome completo',
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
            title: Text('Idade'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Idade',
                  ),
                  controller: _idadeController,
                ),),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child:ListTile(
            title: Text('Peso'),
            subtitle:  TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Peso',
                  ),
                  controller: _pesoController,
                ),),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child:ListTile(
              title: Text('Altura'),
              subtitle:  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      hintText: '  Altura',
                    ),
                    controller: _alturaController,
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
            title: Text('Experiência'),
            subtitle: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: '  Experiência',
                  ),
                  controller: _experienciaController,
                ),),
              ),
            ]),
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
            ])
          ])) // Form
    ]);
  }

  @override
  Widget build(BuildContext context) {
    /*final Map m = ModalRoute.of(context)!.settings.arguments as Map;
    _id = m["id"];
    _obterUsuario();*/
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text("Cadastrar Artista"),
        backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)
      ),
      //drawer: const AppDrawer(),
      body: SingleChildScrollView(
    child:_buildForm(context),
    ));
  }
}




