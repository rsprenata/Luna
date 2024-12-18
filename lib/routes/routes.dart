import 'package:luna/main.dart';
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

class Routes {
static const String initial = MyHomePage.routeName;

static const String home = HomePage.routeName;
static const String homeArtista = HomeArtista.routeName;

static const String login = LoginPage.routeName;
/*static const String clienteList = ListarClientesPage.routeName;
static const String clienteInsert = InserirClientePage.routeName;*/
static const String manterPerfilArtista = ManterPerfilArtistaPage.routeName;
static const String manterPerfilEmpresa = ManterPerfilEmpresaPage.routeName;
//static const String verPerfil = VerUsuarioArtistaPage.routeName;
static const String manterVaga = ManterVagaPage.routeName;
static const String visualizarVaga = VisualizarVagaPage.routeName;

static const String listarVagas = ListarVagasPage.routeName;
static const String listarVagasDisponiveis = ListarVagasDisponiveisPage.routeName;
static const String listarCandidaturasArtista = ListarCandidaturasArtistaPage.routeName;
static const String escolhaPerfil = EscolhaPerfilScreen.routeName;
static const String listarCandidaturasEmpresa = ListarCandidaturasEmpresaPage.routeName;

/*static const String pedidoList = ListarPedidosPage.routeName;
static const String pedidoInsert = InserirPedidoPage.routeName;

static const String produtoList = ListarProdutosPage.routeName;
static const String produtoInsert = InserirProdutoPage.routeName;
static const String produtoEdit = EditarProdutoPage.routeName;*/
}