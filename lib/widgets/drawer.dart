import 'package:luna/provider/auth_provider.dart';
import 'package:luna/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:luna/view/perfil/manter_perfil_artista.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _createHeader(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuario;

    String nivel = usuario?.nivel == 1 ? 'Artista' : 'Empresa';

    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
      ),
      child: Row(
        children: [
          Expanded(
            // Expande o Row para ocupar o espaço disponível
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$nivel: ${usuario?.nome ?? ''}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.visible, // Para mostrar todo o texto
                ),
                const SizedBox(height: 8),
                Text(
                  "Email: ${usuario?.email ?? ''}",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  overflow: TextOverflow.visible, // Para mostrar todo o texto
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text, style: const TextStyle(fontSize: 18)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuario;
    final nivel = usuario?.nivel;
    final idUsuario = usuario?.id;

    return Drawer(
        child: Column(
      // Use Column em vez de ListView
      children: <Widget>[
        Expanded(
          // O Expanded permite que a lista ocupe o espaço disponível
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createHeader(context),
              /*_createDrawerItem(
                  icon: Icons.store,
                  text: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    if (Navigator.canPop(context)) {
                      Navigator.pushNamed(context, Routes.home);
                    }
                  }),*/
              if (nivel == 1) ...[
                _createDrawerItem(
                    icon: Icons.work,
                    text: 'Trabalhos Disponíveis',
                    onTap: () {
                      Navigator.pop(context);
                      /*Navigator.pushNamed(
                          context, Routes.listarVagasDisponiveis);*/
                      Navigator.pushNamed(
                        context,
                        Routes.homeArtista,
                        arguments: <String, dynamic>{
                            "initialTabIndex": 0
                          },
                      );
                    }),
                _createDrawerItem(
                    icon: Icons.view_timeline,
                    text: 'Minhas Candidaturas',
                    onTap: () {
                      Navigator.pop(context);
                      /*Navigator.pushNamed(
                          context, Routes.listarCandidaturasArtista);*/
                      Navigator.pushNamed(
                        context,
                        Routes.homeArtista,
                        arguments: <String, dynamic>{
                            "initialTabIndex": 1
                          },
                      );
                    }),
                _createDrawerItem(
                    icon: Icons.person,
                    text: 'Meu perfil',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.manterPerfilArtista,
                          arguments: <String, dynamic>{
                            "id": idUsuario!,
                            "isReadOnly": false
                          });
                    }),
              ] else if (nivel == 2) ...[
                _createDrawerItem(
                    icon: Icons.work,
                    text: 'Trabalhos',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.listarVagas);
                    }),
                _createDrawerItem(
                    icon: Icons.person,
                    text: 'Meu perfil',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.manterPerfilEmpresa,
                          arguments: <String, int>{"id": idUsuario!});
                    }),
              ],
              // Aqui estão os itens que você deseja que fiquem embaixo
            ],
          ),
        ),
        _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacementNamed(context, Routes.login);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Sucesso!'),
                    behavior: SnackBarBehavior.floating),
              );
            }),
        ListTile(
          title: const Text('v1.0'),
          onTap: () {},
        ),
      ],
    ));
  }
}
