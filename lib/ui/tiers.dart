import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:http/http.dart' as http;
import 'package:staff_app/bloc/bloc.dart';
import 'package:staff_app/model/airplane_class.dart';
import 'package:staff_app/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TiersPage extends StatefulWidget {
  @override
  _TiersPageState createState() => _TiersPageState();
}

class _TiersPageState extends State<TiersPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: TierItem(
                    left: 1,
                    right: 0.5,
                    top: 1,
                    bottom: 0.5,
                    imageUrl: 'https://images.pexels.com/photos/2112638/pexels-photo-2112638.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    title: 'Tier 1 - extra',
                    spaceIncrement: 125000,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: TierItem(
                    left: 0.5,
                    right: 1,
                    top: 1,
                    bottom: 0.5,
                    imageUrl: 'https://images.pexels.com/photos/3126170/pexels-photo-3126170.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    title: 'Tier 2 - large',
                    spaceIncrement: 64000,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: TierItem(
                    left: 1,
                    right: 0.5,
                    top: 0.5,
                    bottom: 1,
                    imageUrl: 'https://images.pexels.com/photos/1058959/pexels-photo-1058959.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    title: 'Tier 3 - medium',
                    spaceIncrement: 27000,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: TierItem(
                    left: 0.5,
                    right: 1,
                    top: 0.5,
                    bottom: 1,
                    imageUrl: 'https://images.pexels.com/photos/1682694/pexels-photo-1682694.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    title: 'Tier 4 - small',
                    spaceIncrement: 8000,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class TierItem extends StatelessWidget {

  final double left;
  final double right;
  final double top;
  final double bottom;
  final String imageUrl;
  final String title;
  final double spaceIncrement;

  const TierItem({
    Key key,
    @required this.left,
    @required this.right,
    @required this.top,
    @required this.bottom,
    @required this.imageUrl,
    @required this.title,
    @required this.spaceIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 20),
            blurRadius: 20,
            color: Colors.black45
          )
        ]
      ),
      padding: EdgeInsets.only(
        left: 16.0 * left,
        right: 16.0 * right,
        top: 16.0 * top,
        bottom: 16.0 * bottom,
      ),
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0)
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0)
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.75)
                    ]
                  )
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0)
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Future<String> futureString = new QRCodeReader().scan();

                  futureString.then((str) async {
                    final qr_response = await http.get('http://119.246.37.218:3000/qrcode/auth?token=$str');

                    if (json.decode(qr_response.body).containsKey('user')) {
                      final user = User.fromJson(json.decode(qr_response.body)['user']);

                      final airplaneClassResponse = await http.get('http://119.246.37.218:3000/airplane_classes/${user.airplaneClassId}');
                      final purchaseLogsResponse = await http.get('http://119.246.37.218:3000/purchase_logs?user_id=${user.id}');

                      final airplaneClass = AirplaneClass.fromJson(json.decode(airplaneClassResponse.body));
                      final space = airplaneClass.binAmount * airplaneClass.binHeight * airplaneClass.binLength * airplaneClass.binWidth / airplaneClass.seatAmount;
                      
                      final purchasableSpace = space * airplaneClass.purchasableSpacePercentage;
                      final purchasedSpace = json.decode(purchaseLogsResponse.body).map((pl) => double.parse(pl['space_increasement'])).reduce((a, b) => a + b);

                      if (purchasedSpace + spaceIncrement <= purchasableSpace) {

                        final storeBloc = BlocProvider.of<StoreBloc>(context);

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Space assignment'),
                              content: Text('Are you confirm to assgin $spaceIncrement cm^3 space to user?'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('No'),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    final response = await http.post('http://119.246.37.218:3000/purchase_logs?token=${(storeBloc.currentState as LoadedStoreState).token}&user_id=${user.id}&store_id=${(storeBloc.currentState as LoadedStoreState).id}&space_increasement=$spaceIncrement');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          }
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('This user cannot purchase this tier due to exceeded purchasable space limit (${purchasedSpace.round() + spaceIncrement.round()} / ${purchasableSpace.round()}).'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () => {
                                    Navigator.of(context).pop()
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          }
                        );
                      }
                    }
                  });
                },
                child: SizedBox.expand(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Total reward space: $spaceIncrement cm^3',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}