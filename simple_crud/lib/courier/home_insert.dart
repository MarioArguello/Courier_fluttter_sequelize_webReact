import 'package:flutter/material.dart';
import 'package:simple_crud/login_registro/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_crud/courier/listas_pedidos/lista_pedidos.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:simple_crud/courier/perfiluser/perfil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController shipper = new TextEditingController();
  TextEditingController consignee = new TextEditingController();
  TextEditingController carrier = new TextEditingController();
  TextEditingController tracking = new TextEditingController();
  TextEditingController valorcompra = new TextEditingController();
  TextEditingController detallecompra = new TextEditingController();
  File file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Map parametros = ModalRoute.of(context).settings.arguments;
    TextEditingController _dato = TextEditingController();
    String _ruta;
    String _image64;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Ingreso nuevo pedido',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(children: <Widget>[
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Shipper",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.ac_unit_sharp,
                    color: Colors.blue[700],
                  ),
                  hintText: 'Ingrese shipper',
                ),
                controller: shipper,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese shipper';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Consignee",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepPurple[700],
                  ),
                  hintText: 'Ingrese consignee',
                ),
                controller: consignee,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese consignee';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Carrier",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.car_rental_sharp,
                    color: Colors.green[700],
                  ),
                  hintText: 'Ingrese carrier',
                ),
                controller: carrier,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese carrier';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tracking",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.code,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Ingrese tracking',
                ),
                controller: tracking,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese tracking';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Valor Compra",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: Colors.limeAccent[700],
                  ),
                  hintText: 'Ingrese valor compra',
                ),
                controller: valorcompra,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese valor compra';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Detalle compra",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(
                    Icons.details,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Ingrese detalle compra',
                ),
                controller: detallecompra,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor detalle compra';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
            ]),
          ),
        ),
        Container(
          height: 140,
          width: 180,
          color: Colors.black12,
          child: file == null
              ? Icon(
                  Icons.image,
                  size: 50,
                )
              : Image.file(
                  file,
                  fit: BoxFit.fill,
                ),
        ),
        SizedBox(height: 10.0),
        MaterialButton(
          minWidth: 300,
          height: 50,
          onPressed: () {
            getgall();
          },
          color: Colors.blue[900],
          child: Text("Ir a galeria",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 30.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () async {
              // Navigator.of(context).pushNamed('/home');
              if (_formKey.currentState.validate()) {
                alertapedido(parametros['idusuario'].toString());
              }
            },
            padding: EdgeInsets.all(25),
            color: Colors.lightBlueAccent,
            child: Text('Enviar pedido',
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
        ),
        SizedBox(height: 50.0),
      ])),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton:
          SpeedDial(icon: Icons.list, backgroundColor: Colors.amber, children: [
        SpeedDialChild(
          child: const Icon(Icons.face),
          label: 'Perfil',
          backgroundColor: Colors.amberAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Perfiluser(idcliente: parametros['idusuario'])),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.list),
          label: 'Lista pedidos',
          backgroundColor: Colors.amberAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      lista(idcliente: parametros['idusuario'])),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.logout),
          label: 'Logaut',
          backgroundColor: Colors.amberAccent,
          onTap: () {
            destruirPreferencias();
            Navigator.of(context).pushNamedAndRemoveUntil(
              LoginPage.tag,
              (route) => false,
            );
          },
        ),
      ]),
    );
  }

  void alertapedido(String idpersona) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text("Estas seguro que deseas realizar el pedido?"),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                var url =
                    Uri.parse('http://192.168.68.101:3000/pedidos/create');
                // Await the http get response, then decode the json-formatted response.
                var response = await http.post(url, body: {
                  'idpersona': idpersona,
                  'shipper': shipper.text,
                  'consignee': consignee.text,
                  'carrier': carrier.text,
                  'tracking': tracking.text,
                  'valorcompra': valorcompra.text,
                  'detallecompra': detallecompra.text,
                  'estado': "A",
                  "foto": file.path.toString(),
                });

                Fluttertoast.showToast(
                    msg: "Reserva realizada con exito",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
                if (response.statusCode == 200) {
                  shipper.clear();
                  consignee.clear();
                  carrier.clear();
                  tracking.clear();
                  valorcompra.clear();
                  detallecompra.clear();
                  Navigator.of(context).pop();
                } else {
                  print("falla al conectar al Api Rest");
                  Fluttertoast.showToast(
                      msg: "Falla al conectar al Api Rest",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1);
                }
              },
              child: Text("Confirmar")),
          FlatButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Pedido cancelado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);

                Navigator.of(context).pop();
              },
              child: Text("Cancelar")),
        ],
      ),
    );
  }

  getgall() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img.path);
    });
  }
}

Future destruirPreferencias() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  print("preferencias destruidas");
}
