import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oclock/pagina_acceso.dart';
import 'package:uuid/uuid.dart';
import 'navigator.dart';
import 'util.dart';

import 'pagina_inicio.dart';

class CrearPerfil extends StatefulWidget {
  @override
  createState() => _CrearPerfil();
}

class _CrearPerfil extends State<CrearPerfil>{
  final _keyFormulrio = GlobalKey<FormState>();
  final _controlNombre = TextEditingController();
  final _controlApellido1 = TextEditingController();
  final _controlApellido2 = TextEditingController();
  final _controlDNI = TextEditingController();
  var _imagen;
  var _imagenURL;
  var _email = "anoymous";
  var _userId;
  var _fotoCorreo = "";
  var _creando = false;


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
        this._fotoCorreo = usuario.photoUrl;
      });
    }
    //else {
    // navegarHacia(context, PaginaAcceso());
    //}
  }
  _ObtenerPerfil() async {

  }
  _seleccionarImagenDeLaGaleria() async {
    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagen = imagen;
    });
  }
  _subirImagenAStorage() async {
    final String uuid = Uuid().v1();

    final url = await (await FirebaseStorage.instance.ref().child("imagenes/image-$uuid.jpg").putFile(_imagen).onComplete).ref.getDownloadURL();

    setState(() {
      _imagenURL = url;
    });
  }
  _guardarPerfil() async {
    setState(() {
      _creando = true;

    });

    if (_imagen != null) await _subirImagenAStorage();
    await Firestore.instance.collection("perfil").document(_userId).setData({'nombre' : _controlNombre.text,'apellido1' : _controlApellido1.text,'apellido2' : _controlApellido2.text,'DNI' : _controlDNI.text, 'email' : _email,'imagenURL' : _imagenURL});
  setState(() {
    _creando = false;
  });
  }


  build(context) =>Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a1a),
        actions: <Widget>[
          ],
  ),
    drawer: Drawer(child: MenuLateral(),),
    backgroundColor: Colors.black,
    body: Container(
      margin: EdgeInsets.all(24.0),
      child: Form(
        key: _keyFormulrio,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextFormField(
                controller: _controlNombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  ),
                validator: (value) {
                  if (value.isEmpty) return 'Profavor introduzca un nombre';
                  return null;
                },
                ),
              ),
            Container (
              padding: EdgeInsets.fromLTRB(0,0,0,20),
              child: TextFormField(
                controller: _controlApellido1,
                decoration: const InputDecoration(labelText: 'Apellido 1',
                  labelStyle:  TextStyle(
                      color:  Colors.black,
                      fontSize: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),),
                validator: (value){
                  if (value.isEmpty) return 'Por favor introduzca el apellido 1';
                  return null;
                },
              ),
            ),
            Container (
              padding: EdgeInsets.fromLTRB(0,0,0,20),
              child: TextFormField(
                controller: _controlApellido2,
                decoration: const InputDecoration(labelText: 'Apellido 2',
                  labelStyle:  TextStyle(
                      color:  Colors.black,
                      fontSize: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),),
                validator: (value){
                  if (value.isEmpty) return 'Por favor introduzca el apellido 2';
                  return null;
                },
              ),
            ),
            Container (
              padding: EdgeInsets.fromLTRB(0,0,0,20),
              child: TextFormField(
                controller: _controlDNI,
                decoration: const InputDecoration(labelText: 'DNI',
                  labelStyle:  TextStyle(
                      color:  Colors.black,
                      fontSize: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),),
                validator: (value){
                  if (value.isEmpty) return 'Por favor introduzca el DNI';
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                  'AÑADIR IMAGEN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
            ),
            Container (
              padding: EdgeInsets.fromLTRB(0,20,0,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _seleccionarImagenDeLaGaleria,
                    child: _imagen == null ? const Icon(Icons.image, size: 150,color: Colors.white,) : Image.file(_imagen, height: 200),
                  ),
            ],
        ),
        ),
            FlatButton(
              color: Color(0xFF7CC7EE),
              textColor: Colors.black,
              onPressed: _creando ? null : () async{
                if (_keyFormulrio.currentState.validate()){
                  await _guardarPerfil();
                  navegarAtras(context);
                }
              },
              padding: EdgeInsets.all(15),
              shape: StadiumBorder(),
              child: const Text('CREAR'),
            ),
          ],
    ),
    ),
    ),
  );
}