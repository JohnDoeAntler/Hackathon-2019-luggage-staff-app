import 'package:flutter/material.dart';
import 'package:staff_app/bloc/bloc.dart';
import 'package:staff_app/bloc/purchase_log_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {

  final PurchaseLogBloc purchaseLogBloc = PurchaseLogBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final storeBloc = BlocProvider.of<StoreBloc>(context);

    purchaseLogBloc.dispatch(
      GetPurchaseLogs((storeBloc.currentState as LoadedStoreState).id)
    );

    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Opacity(
            opacity: 0.1,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: 'https://images.pexels.com/photos/1402407/pexels-photo-1402407.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
              fit: BoxFit.cover,
            ),
          ),
        ),
        BlocBuilder(
          bloc: purchaseLogBloc,
          builder: (context, purchaseLogState) {
            if (purchaseLogState is LoadedPurchaseLogState) {
              if (purchaseLogState.purchaseLogs.length > 0) {
                return Container(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: purchaseLogState.purchaseLogs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: CustomListItemTwo(
                                spaceIncrement: purchaseLogState.purchaseLogs[index].spaceIncreasement,
                                userId: purchaseLogState.purchaseLogs[index].userId,
                                createdAt: purchaseLogState.purchaseLogs[index].createdAt
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                );
              } else {
                return Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.warning, size: 30, color: Colors.white70),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'You have no any scanned luggages.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  )
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: Container(),
              ),
            );
          }
        },
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    purchaseLogBloc.dispose();
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.spaceIncrement,
    this.userId,
    this.createdAt,
  }) : super(key: key);

  final double spaceIncrement;
  final int userId;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Space Increment: $spaceIncrement',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                'User ID: $userId',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Scanned at: $createdAt',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.spaceIncrement,
    this.userId,
    this.createdAt,
  }) : super(key: key);

  final double spaceIncrement;
  final int userId;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: FlutterLogo(
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      spaceIncrement: this.spaceIncrement,
                      userId: this.userId,
                      createdAt: this.createdAt,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
