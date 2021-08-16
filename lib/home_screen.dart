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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -30,
            right: -50,
            child: Image.asset(
              'images/pokeball.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            child: Text('Pokedex',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            top: 100,
            left: 20,
          ),
          Positioned(
            top: 125,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: pokedex.length,
                    itemBuilder: (context, index) {
                      var type = pokedex[index]['type'][0];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: type == 'Grass'
                                ? Colors.greenAccent
                                : type == 'Fire'
                                    ? Colors.redAccent
                                    : type == 'Water'
                                        ? Colors.blue
                                        : type == 'Electric'
                                            ? Colors.yellow
                                            : type == 'Rock'
                                                ? Colors.grey
                                                : type == 'Ground'
                                                    ? Colors.brown
                                                    : type == 'Psychic'
                                                        ? Colors.indigo
                                                        : type == 'Fighting'
                                                            ? Colors.orange
                                                            : type == 'Bug'
                                                                ? Colors
                                                                    .lightGreenAccent
                                                                : type ==
                                                                        'Ghost'
                                                                    ? Colors
                                                                        .deepPurple
                                                                    : type ==
                                                                            'Normal'
                                                                        ? Colors
                                                                            .black26
                                                                        : type ==
                                                                                'Poison'
                                                                            ? Colors.deepPurpleAccent
                                                                            : Colors.pink,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: Image.asset(
                                  'images/pokeball.png',
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 20,
                                child: Text(
                                  pokedex[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned(
                                top: 55,
                                left: 20,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4, bottom: 4),
                                    child: Text(
                                      pokedex[index]['type'][0],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: CachedNetworkImage(
                                  imageUrl: pokedex[index]['img'],
                                  height: 95,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
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
