import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/artista_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ManterPerfilArtistaPage extends StatefulWidget {
  final int? id;

  static const String routeName = '/perfil/ver';

  const ManterPerfilArtistaPage({super.key, this.id});
  @override
  State<ManterPerfilArtistaPage> createState() =>
      _ManterPerfilArtistaPageState();
}

class _ManterPerfilArtistaPageState extends State<ManterPerfilArtistaPage> {
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

  late Artista _artista;
  int? _id;
  bool _obscurePassword = true; // Variável para controlar a visibilidade da senha

  @override
  void dispose() {
    _nomeController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _numeroController.dispose();
    _idadeController.dispose();
    _pesoController.dispose();
    _experienciaController.dispose();
    _senhaController.dispose();
    _alturaController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  void _obterUsuario() async {
    try {
      ArtistaRepository repository = ArtistaRepository();
      _artista = await repository.buscar(_id!);

      _nomeController.text = _artista.nome;
      _enderecoController.text = _artista.endereco;
      _bairroController.text = _artista.bairroEndereco;
      _cidadeController.text = _artista.cidadeEndereco;
      _numeroController.text = _artista.numeroEndereco;
      _enderecoController.text = _artista.endereco;
      _pesoController.text = _artista.peso;
      _emailController.text = _artista.email;
      _telefoneController.text = _artista.telefone;
      _experienciaController.text = _artista.experiencia;
      _senhaController.text = _artista.senha!;
      _alturaController.text = _artista.altura;
      _idadeController.text =
          _artista.idade != null ? _artista.idade.toString() : "";
    } catch (exception) {
      showError(context, "Erro recuperando artista", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      _artista = Artista.novo(
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
    Artista a = await repository.inserir(_artista!);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(a);

    ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logado com sucesso.')));

    Navigator.pushReplacementNamed(context, Routes.home);

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
  } catch (exception) {
    showError(context, "Erro inserindo artista", exception.toString());
  }
    }
    
}


  void _alterar() async {
    _artista.nome = _nomeController.text;
  _artista.email = _emailController.text;
  _artista.senha = _senhaController.text;
  _artista.endereco = _enderecoController.text;
  _artista.telefone = _telefoneController.text;
  _artista.bairroEndereco = _bairroController.text;
  _artista.numeroEndereco = _numeroController.text;
  _artista.cidadeEndereco = _cidadeController.text;
  _artista.peso = _pesoController.text;
  _artista.altura = _alturaController.text;
  _artista.experiencia = _experienciaController.text;
    _artista.idade = int.parse(_idadeController.text);

  try {
    ArtistaRepository repository = ArtistaRepository();
    await repository.alterar(_artista);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Artista editado com sucesso.')));
    Navigator.pop(context);
  } catch (exception) {
    showError(context, "Erro editando artista", exception.toString());
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
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Nome completo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido';
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                  ),
                ),
              ),
            ],
          ),

            Row(
  children: [
    Expanded(
      child: ListTile(
        title: Text('Idade'),
        subtitle: TextFormField(
          controller: _idadeController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            hintText: '  Idade',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo inválido';
            }
            final idade = int.tryParse(value);
            if (idade == null || idade <= 0) {
              return 'Campo inválido';
            }
            return null; // Retorne null se a validação for bem-sucedida
          },
        ),
      ),
    ),
    SizedBox(
      width: 5,
    ),
    Expanded(
      child: ListTile(
        title: Text('Peso'),
        subtitle: TextFormField(
          controller: _pesoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            hintText: '  Peso',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo inválido';
            }
            final peso = double.tryParse(value);
            if (peso == null || peso <= 0) {
              return 'Campo inválido';
            }
            return null; // Retorne null se a validação for bem-sucedida
          },
        ),
      ),
    ),
    SizedBox(
      width: 5,
    ),
    Expanded(
      child: ListTile(
        title: Text('Altura'),
        subtitle: TextFormField(
          controller: _alturaController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            hintText: '  Altura',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo inválido';
            }
            final altura = double.tryParse(value);
            if (altura == null || altura <= 0) {
              return 'Campo inválido';
            }
            return null; // Retorne null se a validação for bem-sucedida
          },
        ),
      ),
    ),
  ],
),

            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Email'),
                    subtitle: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: '  Email',
                      ),
                      validator: (value) {
                        // Validação básica para verificar se é um email válido
                        String pattern = r'^[^@]+@[^@]+\.[^@]+';
                        RegExp regExp = RegExp(pattern);
                        if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
                          return 'Email inválido'; // Mensagem se o email não for válido
                        }
                        return null; // Retorne null se a validação for bem-sucedida
                      },
                    ),
                  ),
                ),
              ],
            ),

            Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Endereço'),
                  subtitle: TextFormField(
                    controller: _enderecoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Endereço',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                  ),
                ),
              ),
            ],
          ),

            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Número'),
                    subtitle: TextFormField(
                      controller: _numeroController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: '  Número',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                        }
                        return null; // Retorne null se a validação for bem-sucedida
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Bairro'),
                    subtitle: TextFormField(
                      controller: _bairroController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: '  Bairro',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                        }
                        return null; // Retorne null se a validação for bem-sucedida
                      },
                    ),
                  ),
                ),
              ],
            ),

            Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Cidade'),
                  subtitle: TextFormField(
                    controller: _cidadeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Cidade',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                  ),
                ),
              ),
            ],
          ),

            Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Telefone'),
                  subtitle: TextFormField(
                    controller: _telefoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Telefone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                  ),
                ),
              ),
            ],
          ),

            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Experiência'),
                  subtitle: TextFormField(
                    controller: _experienciaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Experiência',
                    ),
                    maxLines: null, // Define um número de linhas para caber mais texto
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                  ),
                ),
              ),
            ],
          ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Senha'),
                    subtitle: TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: '  Senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                        }
                        return null; // Retorne null se a validação for bem-sucedida
                      },
                    ),
                  ),
                ),
              ],
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_id != null) {
                        _alterar();
                      } else {
                        _salvar();
                      }
                    }
                  },
                  child: const Text('Salvar')),
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
  void initState() {
    super.initState();
    _id = widget.id;
    if (_id != null) {
      _obterUsuario();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: widget.id != null ? const Text("Meu Perfil") : const Text("Novo Perfil"),
            //backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        //drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: _buildForm(context),
        ));
  }
}
