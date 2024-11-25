import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:luna/helper/error.dart';
import 'package:luna/model/artista.dart';
import 'package:luna/model/empresa.dart';
import 'package:luna/model/especialidade.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/model/vaga.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/repositories/artista_repository.dart';
import 'package:luna/repositories/usuario_repository.dart';
import 'package:luna/repositories/vaga_repository.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dataFormatter.dart';
//import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ManterVagaPage extends StatefulWidget {
  final int? id;

  static const String routeName = '/vaga/inserir';

  const ManterVagaPage({super.key, this.id});
  @override
  State<ManterVagaPage> createState() => _ManterVagaPageState();
}

class _ManterVagaPageState extends State<ManterVagaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  final _qtdVagasController = TextEditingController();

  int? _id;
  late Vaga _vaga;

  Especialidade? _selectedEspecialidade;
  List<Especialidade> especialidades = [
  Especialidade(1, 'Ator/Atriz'),
  Especialidade(2, 'Modelo'),
  Especialidade(3, 'Artista Plástico')];

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
      setState(() {
        _nomeController.text = _vaga.nome;
        _dataController.text = _vaga.data;
        _descricaoController.text = _vaga.descricao;
        _qtdVagasController.text = _vaga.qtdVagas.toString();
        _valorController.text = _vaga.valor;
        _selectedEspecialidade = _vaga.especialidade;
      });
      
    } catch (exception) {
      showError(context, "Erro recuperando trabalho", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
      final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;
      Empresa empresa = Empresa(id: usuario!.id!, nome: "", email: "", senha: "", 
      endereco: "", telefone: "", bairroEndereco: "", numeroEndereco: "",
      cidadeEndereco: "", nivel: 2, cnpj: "");
     
      empresa.id = usuario?.id;
      
    _vaga = Vaga.novo(
        _nomeController.text,
        _descricaoController.text,
        _valorController.text,
        _dataController.text,
        int.parse(_qtdVagasController.text),
        _selectedEspecialidade!,
        empresa);

    try {
      VagaRepository repository = VagaRepository();
      await repository.inserir(_vaga!);
      _nomeController.clear();
      _dataController.clear();
      _descricaoController.clear();
      _valorController.clear();
      _qtdVagasController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trabalho inserida com sucesso.'),
          behavior: SnackBarBehavior.floating));
      Navigator.pop(context, true);
    } catch (exception) {
      showError(context, "Erro inserindo trabalho", exception.toString());
    }
  }

  void _alterar() async {
    _vaga.data = _dataController.text;
    _vaga.descricao = _descricaoController.text;
    _vaga.nome = _nomeController.text;
    _vaga.qtdVagas = int.parse(_qtdVagasController.text);
    _vaga.valor = _valorController.text;
    _vaga.especialidade = _selectedEspecialidade!;

    try {
      VagaRepository repository = VagaRepository();
      await repository.alterar(_vaga);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trabalho editado com sucesso.'),
          behavior: SnackBarBehavior.floating));
      Navigator.pop(context, true);
    } catch (exception) {
      showError(context, "Erro editando trabalho", exception.toString());
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
                    title: const Text('Título da trabalho', style: TextStyle(fontSize: 20)),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        hintText: '  Título da trabalho',
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
                  title: Text('Descrição'),
                  subtitle: TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText: '  Descrição',
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
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Valor', style: TextStyle(fontSize: 20)),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        hintText: '  Valor',
                      ),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                      }
                      return null; // Retorne null se a validação for bem-sucedida
                    },
                      controller: _valorController,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Data', style: TextStyle(fontSize: 20)),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: '  Data (dd/mm/aaaa)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo inválido'; // Mensagem de erro se o campo estiver vazio
                        }

                        // Verificar se a data está no formato correto
                        String datePattern = r'^\d{2}/\d{2}/\d{4}$';
                        RegExp regex = RegExp(datePattern);
                        if (!regex.hasMatch(value)) {
                          return 'Data inválida';
                        }
                        return null;
                      },
                      controller: _dataController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        DateInputFormatter(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                // Outros campos continuam aqui...
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
                      subtitle: DropdownButtonFormField<Especialidade>(
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

            const SizedBox(height: 15),
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
      _obterVaga();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: widget.id != null
                ? const Text("Editar Trabalho")
                : const Text("Novo Trabalho"),
            //backgroundColor: Color.fromRGBO(159, 34, 190, 0.965)),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        //drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: _buildForm(context),
        ),);
  }
}
