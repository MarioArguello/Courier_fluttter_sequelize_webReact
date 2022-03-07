import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:simple_crud/courier/perfiluser/serializacion.dart';

class Perfiluser extends StatefulWidget {
  const Perfiluser({Key key, this.idcliente}) : super(key: key);
  final int idcliente;
  @override
  _Perfiluser createState() => _Perfiluser();
}

double total;

class _Perfiluser extends State<Perfiluser> {
  Future<List<Persona>> getDataReserva(idcliente) async {
    http.Response response = await http.get(
        Uri.parse(
            'http://192.168.68.101:3000/usuario/dataperfilpersona/$idcliente'), //url
        headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<Persona> users = data.map((data) => Persona.fromJson(data)).toList();
      return users;
    });
  }

  @override
  void initState() {
    print(widget.idcliente.hashCode);
    print(widget.idcliente.toString());

    this.getDataReserva(widget.idcliente);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Text(
            'Perfil Usuario',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Persona>>(
              future: getDataReserva(widget.idcliente),
              builder: (context, data) {
                if (data.connectionState != ConnectionState.waiting &&
                    data.hasData) {
                  var userList = data.data;
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        var userData = userList[index];
                        /* return ExpansionTile(
                          key: Key("$index"),
                          title: Text(userData.cantidad ?? ""),
                        );*/

                        return Card(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.all(17),
                            elevation: 20,
                            child: Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.only(
                                  top: 5,
                                  left: 40,
                                  right: 20,
                                ),
                                // height: 500,

                                child: Column(children: <Widget>[
                                  Center(
                                      child: Column(children: [
                                    Text(
                                      userData.nombres,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80.0,
                                          width: 80.0,
                                          decoration: new BoxDecoration(
                                            image: DecorationImage(
                                              image: new AssetImage(
                                                  'assets/boy.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Telefono: ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              userData.telefono,
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Correo: ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              userData.correo,
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Dni: ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              userData.dni,
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    SizedBox(height: 25),
                                  ])),
                                  SizedBox(height: 35)
                                ])));
                      });
                } else {
                  return Center(
                      child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 10,
                    ),
                  ));
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.reply_sharp, size: 30),
        ),
      ),
    );
  }
}
