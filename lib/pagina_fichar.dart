import 'package:flutter/material.dart';
import 'util.dart';

import 'navigator.dart';

class FicharPage extends StatefulWidget {

  @override
  createState() => _FicharPageState();
}
class _FicharPageState extends State<FicharPage>{

  @override
  build(context) =>Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFF1a1a1a),
      actions: <Widget>[
      ],
    ),
    drawer: Drawer(child: MenuLateral(),),
    backgroundColor: Colors.black,
    body:
    Container(
      padding: EdgeInsets.all(20),
      color: Color(0xFF666666),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Color(0xFF666666),
                child: Column(
                  children: [
                    Text('20/04/2021',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF999999),
                child: Column(
                  children: [
                    Text('Inicio',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),
                    ),
                    Text('08:00',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF999999),
                child: Column(
                  children: [
                    Text('Final',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),
                    ),
                    Text('18:00',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF666666),
                child: Column(
                  children: [
                    Text('Total',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),
                    ),
                  Text('08:00',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ],
              ),
              ),
        ],
      ),
        ),

    ),
  );

}