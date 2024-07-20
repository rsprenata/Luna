import 'package:luna/helper/error.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditarUsuarioPage extends StatefulWidget {
  static const String routeName = '/perfil/editar';

  const EditarUsuarioPage({super.key});
  @override
  _EditarUsuarioPageState createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
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

  /*void _salvar() async {
    _usuario!.nome = _nomeController.text;
    try {
      UsuarioRepository repository = UsuarioRepository();
      await repository.alterar(_usuario!);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario editado com sucesso.')));
      Navigator.pop(context);
    } catch (exception) {
      showError(context, "Erro editando usuario", exception.toString());
    }
  }*/

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'CPF'),
                          /*controller: _cpfController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo não pode ser vazio';
                            }
                            if (value.length < 14) {
                              return 'CPF incorreto';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '###.###.###-##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy)
                          ]*/
                          )))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Nome'),
                        controller: _nomeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo não pode ser vazio';
                          }
                          return null;
                        },
                      )))
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
      ),
      //drawer: const AppDrawer(),
      body: _buildForm(context),
    );
  }
}
