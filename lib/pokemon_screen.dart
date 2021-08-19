import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeflutter/models/global.dart';

class PokemonScreen extends StatefulWidget {
  final pokemonDetail;
  final color;
  final heroTag;

  const PokemonScreen({Key? key, this.pokemonDetail, this.color, this.heroTag})
      : super(key: key);

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: widget.color,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              left: 9,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Positioned(
              top: 70,
              left: 20,
              child: Text(
                widget.pokemonDetail['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 20,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  child: Text(
                    widget.pokemonDetail['type'].join(', '),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black26,
                ),
              ),
            ),
            Positioned(
              top: height * 0.18,
              right: -10,
              child: Image.asset('images/pokeball.png',
                  height: 200, fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      createPokemonDataText(width),

                      // Padding widget for evolution was kept seperate because
                      // the formatting was a bit different than the rest of them
                      // because of the formatting of the JSON.

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Text(
                                'Evolution',
                                style: pokemonDataTitleStyle,
                              ),
                            ),
                            widget.pokemonDetail['next_evolution'] != null
                                ? SizedBox(
                                    height: 20,
                                    width: width * 0.55,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget
                                          .pokemonDetail['next_evolution']
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            widget.pokemonDetail[
                                                    'next_evolution'][index]
                                                ['name'],
                                            style: pokemonDataContentStyle,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Text(
                                    'Maxed Out',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.18,
              left: (width / 2) - 100,
              child: CachedNetworkImage(
                imageUrl: widget.pokemonDetail['img'],
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            )
          ], //Children List
        ));
  }

  Widget createPokemonDataText(var width) {
    var pokemonDataTitles = [
      'Name',
      'Height',
      'Weight',
      'Spawn Time',
      'Weakness'
    ];
    var pokemonJSONFields = [
      'name',
      'height',
      'weight',
      'spawn_time',
      'weaknesses'
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        for (var i = 0; i < pokemonDataTitles.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.3,
                  child: Text(
                    pokemonDataTitles[i],
                    style: pokemonDataTitleStyle,
                  ),
                ),
                Container(
                  child: Text(
                    (i == 4) // weaknesses are returned in List format, have to use join in this case
                        ? widget.pokemonDetail[pokemonJSONFields[i]].join(', ')
                        : widget.pokemonDetail[pokemonJSONFields[i]],
                    style: pokemonDataContentStyle,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
