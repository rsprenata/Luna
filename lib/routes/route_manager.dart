import 'package:flutter/material.dart';
import 'package:luna/main.dart';
import 'package:luna/provider/auth_provider.dart';
import 'package:luna/view/escolha_perfil.dart';
import 'package:luna/view/login.dart';
import 'package:luna/view/perfil/listar_candidaturas_artista.dart';
import 'package:luna/view/perfil/listar_candidaturas_empresa.dart';
import 'package:luna/view/perfil/manter_perfil_artista.dart';
import 'package:luna/view/perfil/manter_perfil_empresa.dart';
import 'package:luna/view/usuario/home.dart';
import 'package:luna/view/vaga/listar_vagas.dart';
import 'package:luna/view/vaga/listar_vagas_disponiveis.dart';
import 'package:luna/view/vaga/manter_vaga.dart';
import 'package:luna/view/vaga/visualizar_vaga.dart';
import 'package:provider/provider.dart';
import 'package:luna/routes/routes.dart';


class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      final usuario = Provider.of<AuthProvider>(context, listen: false).usuario;

      switch (settings.name) {
        case Routes.initial:
          return const MyHomePage(title: 'LUNA');
        case Routes.home:
          return const HomePage();
        case Routes.login:
          return const LoginPage();
        case Routes.escolhaPerfil:
          return EscolhaPerfilScreen();
        case Routes.manterPerfilArtista:
          if (settings.arguments != null) {
            if (usuario == null) {
              return const LoginPage();
            }
            final args = settings.arguments as Map<String, dynamic>;
            return ManterPerfilArtistaPage(id: args['id']);
          } else {
            return const ManterPerfilArtistaPage();
          }
        case Routes.manterPerfilEmpresa:
          if (settings.arguments != null) {
            if (usuario == null) {
              return const LoginPage();
            }
            final args = settings.arguments as Map<String, dynamic>;
            return ManterPerfilEmpresaPage(id: args['id']);
          } else {
            return const ManterPerfilEmpresaPage();
          }
        case Routes.manterVaga:
          if (settings.arguments != null) {
            if (usuario == null) {
              return const LoginPage();
            }
            final args = settings.arguments as Map<String, dynamic>;
            return ManterVagaPage(id: args['id']);
          } else {
            return const ManterVagaPage();
          }
        case Routes.visualizarVaga:
          if (usuario == null) {
            return const LoginPage();
          }
          final args = settings.arguments as Map<String, dynamic>;
          return VisualizarVagaPage(id: args['id']);
        case Routes.listarVagas:
          if (usuario == null) {
            return const LoginPage();
          }
          return const ListarVagasPage();
        case Routes.listarVagasDisponiveis:
          if (usuario == null) {
            return const LoginPage();
          }
          return const ListarVagasDisponiveisPage();
        case Routes.listarCandidaturasArtista:
          if (usuario == null) {
            return const LoginPage();
          }
          return const ListarCandidaturasArtistaPage();
        case Routes.listarCandidaturasEmpresa:
          if (usuario == null) {
            return const LoginPage();
          }
          return const ListarCandidaturasEmpresaPage();
        default:
          return const LoginPage();
      }
    });
  }
}
