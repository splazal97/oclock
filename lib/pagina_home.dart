import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oclock/pagina_acceso.dart';
import 'navigator.dart';
import 'util.dart';

import 'pagina_inicio.dart';


class PaginaHome extends StatefulWidget {
  @override
  createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  var _email = "anoymous";
  var _userId;
  var ahora = new DateTime.now();


  @override
  initState() {
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
  _iniciarJornada() async {
    await Firestore.instance.collection("fichar").add({'inicio' : new DateTime.now(),'userID' : _userId});

  }

  _cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    navegarHacia(context, PaginaInicio());
  }

  @override
  build(context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a1a),

        actions: <Widget>[
        ],
      ),
    drawer: Drawer(child: MenuLateral()),
    backgroundColor: Colors.black,
    floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0XFF434343),
      child: Icon(Icons.add),
    onPressed: (){
        _iniciarJornada();

    },
    ),
  );
}