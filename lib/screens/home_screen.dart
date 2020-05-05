import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/farmacias_provider.dart';
import '../widgets/farmacia_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Consumer<FarmaciasProvider>(
                        builder: (_, item, __) => Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: item.getPlaces.length,
                            shrinkWrap: false,
                            itemBuilder: (_, i) => FarmaciaWidget(
                              item.getPlaces[i].name,
                              item.getPlaces[i].abierto ? 'Abierto' : 'Cerrado',
                              item.getPlaces[i].imageUrl,
                              item.getPlaces[i].location,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Stack(
        children: <Widget>[
          Center(
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              shape: StadiumBorder(),
              textColor: Colors.white,
              child: Text('Buscar farmacias cercanas'),
              onPressed: () {
                Provider.of<FarmaciasProvider>(
                  context,
                  listen: false,
                ).fetchPlaces().then((_) {
                  return _showDialog(context);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
