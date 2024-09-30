import 'package:flutter/material.dart';

class EscolhaPerfilScreen extends StatelessWidget {
  static const String routeName = '/escolha';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seu perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de artista
                Navigator.pushNamed(context, '/cadastroArtista');
              },
              child: Text('Sou Artista'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de empresa
                Navigator.pushNamed(context, '/cadastroEmpresa');
              },
              child: Text('Sou Empresa'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
