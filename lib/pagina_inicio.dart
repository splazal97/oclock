import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  var _email = "anoymous";
  var _userId;
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
  _obtenerEmailLogueado() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if (usuario != null) {
      setState(() {
        this._email = usuario.email;
        this._userId = usuario.uid;
      });
    }
  }
  _comprobarPerfil () async{
    var perfil = await Firestore.instance.collection("perfil").document(_userId);
  }

  @override
  build( context) {

    return Scaffold(
      body: const CircularProgressIndicator(),
    );
  }
}
