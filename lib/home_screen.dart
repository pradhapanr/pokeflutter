import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List pokedex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      getPokedexData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
              ),
              itemCount: pokedex.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Text(pokedex[index]['name']),
                          CachedNetworkImage(imageUrl: pokedex[index]['img']),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void getPokedexData() async {
    //get request to Pokedex API
    //code format sourced from https://pub.dev/packages/http
    //API Url: https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json

    var url = Uri.https(
      'raw.githubusercontent.com',
      '/Biuni/PokemonGO-Pokedex/master/pokedex.json',
    );

    await http.get(url).then((value) {
      if (value.statusCode == 200) {
        var jsonObject = convert.jsonDecode(value.body);
        pokedex = jsonObject['pokemon'];
        setState(() {});
      }
    });
  }
}
