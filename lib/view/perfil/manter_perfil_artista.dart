import 'dart:ffi';

import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/especialidade.dart';
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
  final bool isReadOnly; // Novo parâmetro opcional
  
  static const String routeName = '/perfil/ver';

  const ManterPerfilArtistaPage({super.key, this.id, required this.isReadOnly});
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
  //_especialidadeController = 'Ator';
  bool _obscurePassword = true; // Variável para controlar a visibilidade da senha
  Especialidade? _selectedEspecialidade;
  List<Especialidade> especialidades = [
  Especialidade(1, 'Ator/Atriz'),
  Especialidade(2, 'Modelo'),
  Especialidade(3, 'Artista Plástico'),
];



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

      setState(() {
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
          print("_artista.especialidade");
          print(_artista.especialidade.toJson());
      _selectedEspecialidade = _artista.especialidade;
      });

     
    } catch (exception) {
      showError(context, "Erro recuperando artista", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
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
        especialidade: _selectedEspecialidade!,
        idade: int.parse(_idadeController.text));

    try {
      ArtistaRepository repository = ArtistaRepository();
      Artista a = await repository.inserir(_artista!);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(a);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logado com sucesso.'),
          behavior: SnackBarBehavior.floating));

      Navigator.pushReplacementNamed(context, Routes.homeArtista);

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
    _artista.especialidade = _selectedEspecialidade!;

    try {
      ArtistaRepository repository = ArtistaRepository();
      await repository.alterar(_artista);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artista editado com sucesso.'),
          behavior: SnackBarBehavior.floating));
      Navigator.pop(context);
    } catch (exception) {
      showError(context, "Erro editando artista", exception.toString());
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
                        title: const Text('Nome completo',
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_nomeController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Nome completo',
                            fillColor: Color(0)
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
                        title:
                            const Text('Idade', style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_idadeController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Idade',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _idadeController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title:
                            const Text('Peso', style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_pesoController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Peso',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _pesoController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Altura',
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_alturaController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: '  Altura',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                            }
                            return null; // Retorne null se a validação for bem-sucedida
                          },
                          controller: _alturaController,
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
                        'Especialidade',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: widget.isReadOnly
                          ? Text(
                              _selectedEspecialidade != null
                                  ? _selectedEspecialidade!.descricao
                                  : 'Nenhuma especialidade selecionada',
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                            )
                          : 
                            DropdownButtonFormField<Especialidade>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                              value: _selectedEspecialidade, // O valor atual selecionado
                              items: especialidades.map((especialidade) {
                                return DropdownMenuItem<Especialidade>(
                                  value: especialidade, // Define o objeto Especialidade como valor
                                  child: Text(especialidade.descricao), // Exibe a descrição no dropdown
                                );
                              }).toList(),
                              onChanged: (Especialidade? value) {
                                setState(() {
                                  print("value");
                                  print(value!.toJson());
                                  _selectedEspecialidade = value; // Atualiza o valor selecionado
                                });
                              },
                              hint: const Text('Selecione uma especialidade'),
                            )

                    ),
                  ),
                ],

              ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title:
                            const Text('Email', style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_emailController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_enderecoController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_numeroController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_bairroController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_cidadeController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                            style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_telefoneController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) : TextFormField(
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
                        title: Text('Experiência',
                        style: TextStyle(fontSize: 18)),
                        subtitle: widget.isReadOnly ? Text(_experienciaController.text,
                            style: const TextStyle(fontSize: 16,color: Colors.black)) :TextFormField(
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
                ]),
                widget.isReadOnly ? const SizedBox.shrink() : 
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
                widget.isReadOnly ? const SizedBox.shrink() :
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
                        child: const Text('Cancelar', style: TextStyle(fontSize: 18)),
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
                            ? const Text("Salvar", style: TextStyle(fontSize: 18))
                            : const Text("Cadastrar", style: TextStyle(fontSize: 18)),
                      ),
                    )
                  
                  
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
            title: widget.id != null
                ? widget.isReadOnly ? const Text("Perfil Artista") : const Text("Meu Perfil")
                : const Text("Novo Perfil"),
            //backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        //drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: _buildForm(context),
        ));
  }
}
