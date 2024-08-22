import 'package:flutter/material.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/perfil/inserir_perfil_artista.dart';
import 'package:luna/view/perfil/inserir_perfil_empresa.dart';
import 'package:luna/view/perfil/manter_perfil_artista.dart';
import 'package:luna/view/vaga/listar_vagas.dart';
import 'package:luna/view/vaga/inserir_vaga.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LUNA'),
      routes: {
        Routes.home: (context) => const MyHomePage(title: 'LUNA'),
        Routes.usuarioEdit:(context) => const EditarUsuarioArtistaPage(),
        Routes.verPerfil:(context) => const VerUsuarioArtistaPage(),
        Routes.listarVagas:(context) => const ListarVagasPage(),
        Routes.inserirVaga:(context) => const InserirVagaPage(),
        //FIXME Routes.usuarioEmpresaEdit:(context) => const EditarUsuarioEmpresaPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, EditarUsuarioArtistaPage.routeName);
            }, child: Text("Novo Perfil")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, VerUsuarioArtistaPage.routeName,
        arguments: <String, int>{"id": 10});
            }, child: Text("Ver Perfil")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, ListarVagasPage.routeName);
            }, child: Text("Listar Vagas")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, InserirVagaPage.routeName);
            }, child: Text("Nova Vaga")),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
