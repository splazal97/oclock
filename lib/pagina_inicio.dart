import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oclock/pagina_home.dart';
import 'pagina_acceso.dart';
import 'util.dart';
class PaginaInicio extends StatefulWidget {
  @override
  createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio>{
  void initState(){
    super.initState();
    _comprobarLogin();
  }

  _comprobarLogin() async {

    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      navegarHacia(context, PaginaHome());
    } else {
      navegarHacia(context, PaginaAcceso());
    }
  }

  @override
  build( context) {

    return Scaffold(
      body: const CircularProgressIndicator(),
    );
  }
}