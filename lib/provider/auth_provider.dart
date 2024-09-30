import 'package:flutter/material.dart';
import 'package:luna/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;
  bool get isLoggedIn => _usuario != null;

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.remove('usuario');
    String? usuarioJson = await prefs.getString('usuario');

    //print(usuarioJson);
    if (usuarioJson != null) {
      _usuario = Usuario.fromJson(usuarioJson);
    } else {
      _usuario = null;
    }

    notifyListeners();
  }

  Future<void> login(Usuario usuario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', usuario.toJson());
    
    _usuario = usuario;

    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario');

    _usuario = null;
    
    notifyListeners();
  }
}
