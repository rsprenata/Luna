import 'package:flutter/material.dart';
import 'package:luna/routes/routes.dart';

class EscolhaPerfilScreen extends StatelessWidget {
  static const String routeName = '/escolha';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu perfil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de artista
                Navigator.pushNamed(context, Routes.manterPerfilArtista);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Colors.black,
              ),
              child: const Text('Sou Artista'),
            ),
            const SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de empresa
                Navigator.pushNamed(context, Routes.manterPerfilEmpresa);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Colors.black,
              ),
              child: const Text('Sou Empresa'),
            ),
          ],
        ),
      ),
    );
  }
}
