import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:simple_crud/courier/serial.dart';
import 'package:simple_crud/courier/perfiluser/perfil.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:simple_crud/courier/listas_pedidos/Lista_eliminar.dart';
import 'package:simple_crud/courier/listas_pedidos/Lista_pedidos.dart';

class lista_envio extends StatefulWidget {
  const lista_envio({Key key, this.idcliente}) : super(key: key);
  final int idcliente;
  @override
  _lista_envio createState() => _lista_envio();
}

double total;

class _lista_envio extends State<lista_envio> {
  Future<List<Pedidos>> getDataPedido(idcliente) async {
    http.Response response = await http
        .get(Uri.parse('http://192.168.68.101:3000/Enviar/$idcliente'), //url
            headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<Pedidos> users = data.map((data) => Pedidos.fromJson(data)).toList();
      return users;
    });
  }

  @override
  void initState() {
    print(widget.idcliente.hashCode);
    print(widget.idcliente.toString());
    this.getDataPedido(widget.idcliente);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Text(
            'Pedidos enviados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: new Icon(
                Icons.person,
                size: 40,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Perfil Usuario..",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Perfiluser(idcliente: widget.idcliente)),
                );
              },
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder<List<Pedidos>>(
              future: getDataPedido(widget.idcliente),
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
                          color: Colors.amberAccent,
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
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            alignment: Alignment.bottomLeft,
                                            icon: new Icon(
                                              Icons.local_shipping_outlined,
                                              size: 40,
                                            ),
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Su pedido ya fue enviado",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1);
                                            }),
                                      ]),
                                  Text(
                                    "Pedido #  " +
                                        userData.idpedidos.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  const Divider(
                                    height: 10,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 140,
                                    width: 180,
                                    color: Colors.black12,
                                    child: userData.foto == null
                                        ? Icon(
                                            Icons.image,
                                            size: 50,
                                          )
                                        : Image.file(
                                            File(userData.foto),
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shipper : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            userData.shipper,
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
                                        "Consignee: ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            userData.consignee,
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
                                        "Tracking : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            userData.tracking,
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
                                        "Valor compra : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            userData.valorcompra,
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
                                        "Detalle compra : ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            userData.detallecompra,
                                            style: TextStyle(
                                              fontSize: 13,
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
                                        "Estado : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            userData.estado == 'A'
                                                ? 'Activo'
                                                : userData.estado == 'S'
                                                    ? 'enviado'
                                                    : 'Recivido...',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ])),
                              ])),
                        );
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
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: SpeedDial(
            icon: Icons.list,
            backgroundColor: Colors.amber,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.mobile_friendly_outlined),
                label: 'Pedidos recividos',
                backgroundColor: Colors.blue[300],
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            lista_eliminar(idcliente: widget.idcliente)),
                  );
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.local_shipping_outlined),
                label: 'Pedidos enviados',
                backgroundColor: Colors.amberAccent,
                onTap: () {
                  setState(() {});
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.mood),
                label: 'Pedidos activos',
                backgroundColor: Colors.green[300],
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            lista(idcliente: widget.idcliente)),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
