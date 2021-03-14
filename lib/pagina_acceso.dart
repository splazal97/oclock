import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'util.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pagina_home.dart';


class PaginaAcceso extends StatefulWidget{
  @override
  createState() => _PaginaAccesoState();
}

class _PaginaAccesoState extends State<PaginaAcceso> {
  final _keyFormulario = GlobalKey<FormState>();
  var _mensajeError ="";
  var _accedido = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  loguearConGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() !=null);
    try {
        if (user != null) return navegarHacia(context, PaginaHome());
      }
      catch (e) {
      setState(() {
        _mensajeError = e.message;
        _accedido = false;
      });
    }
  }
  @override
  build(context) {
    return Scaffold(
        backgroundColor:  Color(0xFF434343),
        body: Container (
          margin: EdgeInsets.all(24.0),

          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Image.asset('assets/infoplaza.png', width: 200.0,height: 200.0),
                _signInButton(),
                _buildMensajeDeError()
              ],
            ),
          ),
        )
    );
  }

  Widget _signInButton() {
    return
      Container(
        padding: EdgeInsets.fromLTRB(0,40,0,0),

        child: FlatButton(
          splashColor: Colors.grey,
          color: Colors.grey,
          //color: Color(0xFFBF5A36),
          onPressed: () {
            loguearConGoogle();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Iniciar sesion con Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7CC7EE),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }

  _buildMensajeDeError() {
    if (_mensajeError.length > 0 && _mensajeError != null)
      return Text(
        _mensajeError,
        style: TextStyle(
          color: Colors.red,
        ),
      );
    return Container(
      height: 0.0,
    );
  }
}

