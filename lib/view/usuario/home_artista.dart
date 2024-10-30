import 'package:flutter/material.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/view/perfil/listar_candidaturas_artista.dart';
import 'package:luna/view/vaga/listar_vagas_disponiveis.dart';
import 'package:luna/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomeArtista extends StatelessWidget {
  static const String routeName = '/homeartista';
  final int initialTabIndex;
  const HomeArtista({super.key, this.initialTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return DefaultTabController(
      length: 2, 
      initialIndex: initialTabIndex,
      child: Scaffold(
        endDrawer: authProvider.isLoggedIn ? const AppDrawer() : null,
        appBar: AppBar(
          title: const Text("LUNA"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Trabalhos Disponíveis",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "Minhas Candidaturas",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListarVagasDisponiveisPage(),
            ListarCandidaturasArtistaPage(),
          ],
        ),
      ),
    );
  }
}
