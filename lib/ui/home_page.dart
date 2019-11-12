import 'package:flutter/material.dart';
import 'package:gifs/Widgets/GifTable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gifs/global.dart' as global;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int offset = 0;

  Future<Map> _getSearch() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(global.trendingApi);
    } else {
      response = await http.get(global.searchApi(_search, offset));
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(global.gifAppbar),
      ),
      backgroundColor: Colors.black26,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Pesquisar',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Texto Vazio!';
                  }
                  return null;
                },
                onFieldSubmitted: (text) {
                  setState(() {
                    _search = controller.text;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getSearch(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return CreateGifTable(
                          context: _,
                          snapshot: snapshot,
                          query: _search,
                          click: () {
                            setState(() {
                              offset += 19;
                            });
                          });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
