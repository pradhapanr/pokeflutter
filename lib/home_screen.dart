import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeflutter/pokemon_screen.dart';
import 'package:pokeflutter/models/global.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List pokedex;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getPokedexData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //var height = MediaQuery.of(context).size.height;
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
            top: 80,
            left: 20,
          ),
          Positioned(
            top: 125,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  // Setting up grid view for the Pokemon Cards
                  // 2 Cards per Row
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: pokedex.length,
                    itemBuilder: (context, index) {
                      var type = pokedex[index]['type'][0];
                      return InkWell(
                        child: Ink(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorMap[type],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    //Widget for the pokeball image on the card
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                    //Widget for the Pokemon Name
                                    top: 30,
                                    left: 20,
                                    child: Text(
                                      pokedex[index]['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // Widget for the Pokemon Type
                                    // Uses BoxDecoration for a bold appearance.
                                    top: 55,
                                    left: 20,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4),
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
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // Widget for the image of the pokemon
                                    // Uses the CachedNetworkImage library to load the images
                                    bottom: 2,
                                    right: 2,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex[index]['img'],
                                      height: 90,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Uses navigator class to load Pokemon Data page and passes in the
                          // relative JSON object, index, and color for the page to use.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PokemonScreen(
                                pokemonDetail: pokedex[index],
                                heroTag: index,
                                color: colorMap[type],
                              ),
                            ),
                          );
                        },
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

    await http.get(url).then(
      (value) {
        //Simple check to validate that HTTP request response is valid
        //TODO: Create reload scenario in case reponse is false
        if (value.statusCode == 200) {
          var jsonObject = convert.jsonDecode(value.body);
          pokedex = jsonObject['pokemon'];
          setState(() {});
        }
      },
    );
  }
}
