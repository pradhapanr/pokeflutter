import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
}
