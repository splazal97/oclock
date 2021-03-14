import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oclock/pagina_acceso.dart';
import 'navigator.dart';
import 'util.dart';

import 'pagina_inicio.dart';

class CrearPerfil extends StatefulWidget {
  @override
  createState() => _CrearPerfil();
}

class _CrearPerfil extends State<CrearPerfil>{
  var _email = "anoymous";
  var _userId;

  @override
  void initState() {
    super.initState();
    _obtenerEmailLogueado();
  }
  _obtenerEmailLogueado() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      setState(() {
        this._email = usuario.email;
        this._userId = usuario.uid;
      });
    }
    //else {
    // navegarHacia(context, PaginaAcceso());
    //}
  }


  build(context) =>Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a1a),
        actions: <Widget>[

        ],
      ),
    drawer: Drawer(child: MenuLateral(),),
    backgroundColor: Colors.black,
  );
}