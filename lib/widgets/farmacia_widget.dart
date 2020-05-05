import 'package:flutter/material.dart';
import 'package:flutter_farmacias_argentina/screens/map_screen.dart';

class FarmaciaWidget extends StatelessWidget {
  final String name;
  final String abierto;
  final String imageUrl;
  final Map<String, dynamic> location;

  FarmaciaWidget(this.name, this.abierto, this.imageUrl, this.location);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
              ),
              Column(
                children: <Widget>[
                  Text(name),
                  Text(
                    abierto,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              FlatButton.icon(
                icon: Icon(Icons.map),
                label: Text('Ver'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => MapScreen(
                        title: name,
                        location: location,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
