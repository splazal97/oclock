import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oclock/navigator.dart';
import 'package:oclock/pagina_home.dart';
import 'pagina_acceso.dart';
import 'util.dart';

class PaginaPerfil extends StatefulWidget {
  @override
  createState() => _PaginaPerfil();
}

class _PaginaPerfil extends State<PaginaPerfil>{
  var _email = "nonymous";
  var usuario ="anonymous";

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
      });
    }
  }
  build(contezt) => Scaffold (
    appBar: AppBar(
      backgroundColor: Color(0xFF1a1a1a),
      actions: <Widget>[

      ],
    ),
    drawer: Drawer(child: MenuLateral(),),
    backgroundColor: Colors.black,
  );


}