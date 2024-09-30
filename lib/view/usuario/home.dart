import 'package:flutter/material.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/view/login.dart';
import 'package:luna/view/perfil/listar_candidaturas_artista.dart';
import 'package:luna/view/perfil/manter_perfil_artista.dart';
import 'package:luna/view/vaga/listar_vagas.dart';
import 'package:luna/view/vaga/listar_vagas_disponiveis.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuario;
    final nivel = usuario?.nivel;
    final idUsuario = usuario?.id;

    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("LUNA"),
      ),
      endDrawer: authProvider.isLoggedIn ? const AppDrawer() : null,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              if (nivel == 1) ...[
                _buildSquareButton(
                    context, Icons.person, "Meu Perfil", Colors.blue, Routes.manterPerfilArtista,
                    arguments: {'id': idUsuario}),
                _buildSquareButton(
                    context, Icons.work, "Vagas Disponíveis", Colors.green, Routes.listarVagasDisponiveis),
                _buildSquareButton(
                    context, Icons.accessible_forward, "Minhas Candidaturas", Colors.purple, Routes.listarCandidaturasArtista),
              ]
              else if (nivel == 2) ...[
                _buildSquareButton(
                    context, Icons.person, "Meu Perfil", Colors.blue, Routes.manterPerfilEmpresa,
                    arguments: {'id': idUsuario}),
                _buildSquareButton(
                    context, Icons.work, "Listar Vagas", Colors.green, Routes.listarVagas),
              ]
              /* Outros botões que você queira */
              /*_buildSquareButton(context, Icons.home, "Home", Colors.blue, '/home'),
    _buildSquareButton(context, Icons.shopping_cart, "Carrinho", Colors.red, '/carrinho'),
    _buildSquareButton(context, Icons.settings, "Configurações", Colors.purple, '/configuracoes'),
    _buildSquareButton(context, Icons.info, "Sobre", Colors.orange, '/sobre'),
    _buildSquareButton(context, Icons.logout, "Sair", Colors.brown, '/logout'),*/
            ],
          )),

      /*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, ListarVagasPage.routeName);
            }, child: const Text("Listar Vagas")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, ListarVagasDisponiveisPage.routeName);
            }, child: const Text("Listar Vagas Disponíveis")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, ListarCandidaturasArtistaPage.routeName);
            }, child: const Text("Listar minhas candidaturas")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, LoginPage.routeName);
            }, child: const Text("Login")),
          ],
        ),
      ),*/
    );
  }

  Widget _buildSquareButton(BuildContext context, IconData icon, String label,
      Color color, String routeName,
      {Object? arguments}) {
    return GestureDetector(
      onTap: () {
        // Navegar para a rota especificada com argumentos
        Navigator.pushNamed(context, routeName, arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
