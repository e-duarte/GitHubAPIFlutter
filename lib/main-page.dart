import 'package:http/http.dart' as http;
import 'package:examples/user.dart';
import 'package:examples/repos.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

final url = 'https://api.github.com/users/';

class Home extends StatefulWidget {
  final String login;

  Home({this.login});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<User> getDataUser(user) async {
    final response = await http.get(Uri.parse(url + user));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }

  Future<List<Repos>> getDataRepo(user) async {
    final response = await http.get(Uri.parse(url + user));

    if (response.statusCode == 200) {
      final user = User.fromJson(json.decode(response.body));

      final responseRepo = await http.get(Uri.parse(user.reposUrl));
      // Repos.fromJson(json.decode(responseRepo.body));
      Iterable l = json.decode(responseRepo.body);
      List<Repos> repos =
          List<Repos>.from(l.map((model) => Repos.fromJson(model)));

      return repos;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }

  showAlertDiolog(BuildContext context) {
    // configura o button
    Widget yes = TextButton(
      child: Text('yes'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget no = TextButton(
      child: Text('no'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Do you want to closed this app?"),
      // content: Text(""),
      actions: [
        no,
        yes,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github User API'),
        actions: [
          Container(
            alignment: Alignment.centerLeft,
            child: StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // showAlertDiolog(context);
                  return Text(
                    '00:00',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Text(
                    '00:${snapshot.data.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  );
                }
              },
              initialData: 0,
              stream: _stream(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => showAlertDiolog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: getDataUser(widget.login),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: Text("Carregando..."));
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Erro ao carregar..."),
                            );
                          } else {
                            return Text(snapshot.data.name);
                          }
                      }
                    },
                  ),
                  FutureBuilder(
                    future: getDataUser(widget.login),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: Text("Carregando..."));
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Erro ao carregar..."),
                            );
                          } else if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data.avatarUrl,
                              width: 150.0,
                              height: 120.0,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                      }
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('More informations and options'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: getDataRepo(widget.login),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Erro ao carregar..."),
              );
            } else if (snapshot.hasData) {
              List<Repos> repos = snapshot.data;

              return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: repos.length * 2,
                  itemBuilder: (context, i) {
                    if (i.isOdd) return Divider();

                    final index = i ~/ 2;

                    return ListTile(
                      title: Text(repos[index].name),
                      subtitle: Text(repos[index].description == null
                          ? ''
                          : repos[index].description),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Stream<int> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<int> stream = Stream<int>.periodic(interval, transform);
    stream = stream.take(5);
    return stream;
  }

  int transform(int value) {
    return value;
  }
}
