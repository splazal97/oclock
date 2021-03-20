
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oclock/pagina_acceso.dart';
import 'package:oclock/pagina_home.dart';
import 'package:oclock/perfil.dart';

import 'crear_perfil.dart';
import 'util.dart';
import 'pagina_inicio.dart';

class MenuLateral extends StatefulWidget{


  @override
  _MenuLateralState createState() =>_MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral>{
  var _email  = "";
  var _user = "";
  var _foto= "";
  final GoogleSignIn googleSignIn = GoogleSignIn();

  initState(){
    super.initState();
    _obtenerLogeado();
  }
  _obtenerLogeado() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if (usuario != null){
      setState(() {
        this._email = usuario.email;
        this._user = usuario.displayName;
        this._foto = usuario.photoUrl;

      });
    }
  }

  _cerrarSession() async {
    await googleSignIn.signOut();
    navegarHacia(context, PaginaAcceso());
  }

  void _irInicioUser() async {
    navegarHacia(context, PaginaHome());
  }
  void _irPerfil() async {
    navegarHacia(context, CrearPerfil());
  }
  @override
  Widget build(BuildContext context){
    return Drawer(

      child: Container(
        color: Color(0xFF1a1a1a),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                title: Text("$_user",style: TextStyle(
                    fontSize: 25,color: Colors.white
                ),
                ),
                subtitle: Text("$_email",style: TextStyle(color: Colors.white),),
                leading: CircleAvatar(backgroundImage: NetworkImage("$_foto"),),
              ),
            ),
            ListTile(
              title: Text('Inicio',style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.home,color: Color(0xff7CC7EE)),
              onTap: (){
                _irInicioUser();
              },
            ),
            ListTile(
              title: Text('Perfil',style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.person,color: Color(0xff7CC7EE)),
              onTap: (){
                _irInicioUser();
              },
            ),

            ListTile(
                title: Text('Salir',style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.exit_to_app, color: Color(0xff7CC7EE)),
                onTap: (){_cerrarSession();}
            ),
          ],
        ),
      ),
    );
  }
}