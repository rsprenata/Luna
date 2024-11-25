import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/empresa.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/empresa_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ManterPerfilEmpresaPage extends StatefulWidget {
  final int? id;

  static const String routeName = '/perfilEmpresa/editar';

  const ManterPerfilEmpresaPage({super.key, this.id});
  @override
  State<ManterPerfilEmpresaPage> createState() =>
      _ManterPerfilEmpresaPageState();
}

class _ManterPerfilEmpresaPageState extends State<ManterPerfilEmpresaPage> {
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
  final _descricaoController = TextEditingController();

  int? _id = 0;
  bool _obscurePassword = true; // Variável para controlar a visibilidade da senha


  late Empresa _empresa;
  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _obterUsuario() async {
    try {
      //var maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
      EmpresaRepository repository = EmpresaRepository();
      _empresa = await repository.buscar(_id!);

      _nomeController.text = _empresa.nome;
      _bairroController.text = _empresa.bairroEndereco;
      _cidadeController.text = _empresa.cidadeEndereco;
      _numeroController.text = _empresa.numeroEndereco;
      _senhaController.text = _empresa.senha!;
      _emailController.text = _empresa.email;
      _telefoneController.text = _empresa.telefone;
      _enderecoController.text = _empresa.endereco;
      _cnpjController.text = _empresa.cnpj;
      _descricaoController.text = _empresa.descricao!;
    } catch (exception) {
      showError(context, "Erro recuperando empresa", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
    Empresa _empresa = Empresa.novo(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text,
        endereco: _enderecoController.text,
        telefone: _telefoneController.text,
        bairroEndereco: _bairroController.text,
        numeroEndereco: _numeroController.text,
        cidadeEndereco: _cidadeController.text,
        nivel: 2,
        cnpj: _cnpjController.text,
        descricao: _descricaoController.text);

    try {
      EmpresaRepository repository = EmpresaRepository();
      Empresa e = await repository.inserir(_empresa);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(e);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logado com sucesso.'),
          behavior: SnackBarBehavior.floating));

      Navigator.pushReplacementNamed(context, Routes.listarVagas);

      _nomeController.clear();
      _enderecoController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _numeroController.clear();
      _enderecoController.clear();
      _descricaoController.clear();
      _cnpjController.clear();
      _enderecoController.clear();
      _descricaoController.clear();
      _emailController.clear();
      _telefoneController.clear();
    } catch (exception) {
      showError(context, "Erro inserindo empresa", exception.toString());
    }
  }

  void _alterar() async {
    _empresa.nome = _nomeController.text;
    _empresa.bairroEndereco = _bairroController.text;
    _empresa.cidadeEndereco = _cidadeController.text;
    _empresa.numeroEndereco = _numeroController.text;
    _empresa.senha = _senhaController.text;
    _empresa.email = _emailController.text;
    _empresa.telefone = _telefoneController.text;
    _empresa.endereco = _enderecoController.text;
    _empresa.cnpj = _cnpjController.text;
    _empresa.descricao = _descricaoController.text;

    try {
      EmpresaRepository repository = EmpresaRepository();
      await repository.alterar(_empresa);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empresa editada com sucesso.'),
          behavior: SnackBarBehavior.floating));
      Navigator.pop(context);
    } catch (exception) {
      showError(context, "Erro editando empresa", exception.toString());
    }
  }

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Nome da empresa',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Nome da empresa',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _nomeController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Descrição da empresa',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Descrição da empresa',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _descricaoController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('CNPJ da empresa',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  CNPJ da empresa',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _cnpjController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title:
                            const Text('Email', style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _emailController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Endereço',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Endereço',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _enderecoController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Número',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Número',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _numeroController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Bairro',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Bairro',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _bairroController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Cidade',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Cidade',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _cidadeController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Telefone',
                            style: TextStyle(fontSize: 20)),
                        subtitle: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Telefone',
                          ),
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                        }
                        return null; // Retorne null se a validação for bem-sucedida
                      },
                          controller: _telefoneController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  
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
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150, // Define a largura desejada para o botão "Cancelar"
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Cancelar', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 150, // Define a largura desejada para o botão "Salvar"
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_id != null) {
                              _alterar();
                            } else {
                              _salvar();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                          foregroundColor: Colors.black,
                        ),
                        child: widget.id != null
                            ? const Text("Salvar", style: TextStyle(fontSize: 20))
                            : const Text("Cadastrar", style: TextStyle(fontSize: 20)),
                      ),
                    )
                    
                  ],
                )


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
            title: widget.id != null
                ? const Text("Meu Perfil")
                : const Text("Cadastrar Empresa"),
            //backgroundColor: const Color.fromRGBO(159, 34, 190, 0.965)),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        //drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: _buildForm(context),
        ));
  }
}
