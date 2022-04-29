import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:consumer_api_basic_example/models/reqres_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Consumer API basic",
      home: MiPagina(),
    );
  }
}

Future<ReqResRespuesta> getusuarios() async {
  try {
    http.Response respuesta =
        await http.get(Uri.parse("https://reqres.in/api/users"));

    return reqResRespuestaFromJson(respuesta.body);
  } catch (e) {
    throw Exception("Error al solicitar datos");
  }
}

class MiPagina extends StatelessWidget {
  const MiPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Consumer API basic"),
        ),
        body: FutureBuilder(
          future: getusuarios(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return _ListaUsuarios(snapshot.data.data);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  // ListView _ListaUsuarios() => ListView();

}

class _ListaUsuarios extends StatelessWidget {
  final List<Usuario> listaUsuarios;

  const _ListaUsuarios(this.listaUsuarios);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaUsuarios.length,
        itemBuilder: (BuildContext context, int i) {
          final usuario = listaUsuarios[i];
          return FadeIn(
            delay: Duration(milliseconds: 100 * i),
            child: ListTile(
              title: Text("${usuario.firstName} ${usuario.lastName} "),
              subtitle: Text("${usuario.email}"),
              trailing: Image.network("${usuario.avatar}"),
            ),
          );
        });
  }
}
