import 'package:luna/provider/auth_provider.dart';
import 'package:luna/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _createHeader(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuario;

    String nivel = usuario?.nivel == 1 ? 'Artista' : 'Empresa';

    return DrawerHeader(
              decoration: const BoxDecoration(
                //color: Colors.blue,
                color: Colors.deepPurple
              ),
              child: Row(
                children: [Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$nivel: ${usuario?.nome ?? ''}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Email: ${usuario?.email ?? ''}",
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
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
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _createHeader(context),
        _createDrawerItem(
            icon: Icons.store,
            text: 'Home',
            onTap: () {
              Navigator.pop(context);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              //Navigator.pushReplacementNamed(context, Routes.home);
            }),
        _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
                context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(context, Routes.home);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sucesso!'), behavior: SnackBarBehavior.floating),
                );
            }),
        /*_createDrawerItem(
            icon: Icons.groups,
            text: 'Clientes',
            onTap: () {
              Navigator.pop(context);//Drawer
              if (Navigator.canPop(context)) {
                Navigator.pop(context);//Retira pagina atual da pilha
              }
              Navigator.pushNamed(context, Routes.usuarioEdit);
            }),
        _createDrawerItem(
            icon: Icons.sell,
            text: 'Produtos',
            onTap: () {
              Navigator.pop(context);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushNamed(context, Routes.produtoList);
            }),
        _createDrawerItem(
            icon: Icons.shopping_cart,
            text: 'Pedidos',
            onTap: () {
              Navigator.pop(context);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushNamed(context, Routes.pedidoList);
            }),*/
        ListTile(
          title: const Text('v1.0'),
          onTap: () {},
        )
      ],
    ));
  }
}
