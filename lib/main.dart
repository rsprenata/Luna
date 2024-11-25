import 'package:flutter/material.dart';
import 'package:luna/model/usuario.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/routes/route_manager.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/escolha_perfil.dart';
import 'package:luna/view/login.dart';
import 'package:luna/view/perfil/manter_perfil_empresa.dart';
import 'package:luna/view/perfil/listar_candidaturas_artista.dart';
import 'package:luna/view/perfil/listar_candidaturas_empresa.dart';
import 'package:luna/view/perfil/manter_perfil_artista.dart';
import 'package:luna/view/usuario/home.dart';
import 'package:luna/view/usuario/home_artista.dart';
import 'package:luna/view/vaga/listar_vagas.dart';
import 'package:luna/view/vaga/listar_vagas_disponiveis.dart';
import 'package:luna/view/vaga/manter_vaga.dart';
import 'package:luna/view/vaga/visualizar_vaga.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:luna/view/splash_page.dart'; // Importação da SplashPage
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.checkLoginStatus();

  runApp(ChangeNotifierProvider(
    create: (context) => authProvider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteManager.generateRoute,
      home: const SplashScreen(), // Altere aqui para usar a SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Chama a função para redirecionar após alguns segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            return authProvider.isLoggedIn 
              ? (authProvider.usuario!.nivel == 2 
                  ? const ListarVagasPage() 
                  : const HomeArtista(initialTabIndex: 0))
              : const LoginPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage(); // Retorna a tela de splash
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/initial';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      endDrawer: authProvider.isLoggedIn ? const AppDrawer() : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, LoginPage.routeName);
            }, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
