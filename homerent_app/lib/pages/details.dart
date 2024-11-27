import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String imageUrl;
  Details({super.key, required this.imageUrl});

  @override
  State<Details> createState() => _DetailsState(imageUrl);
}

class _DetailsState extends State<Details> {
  String imageUrl;
  _DetailsState(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 269,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("$imageUrl"), fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
