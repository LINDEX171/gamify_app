import 'package:flutter/material.dart';
import 'package:gamify_app/data.dart';
import 'package:gamify_app/widgets/scrollable_games_widget.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _deviceHeight;
  var _deviceWidth;
  var _selectedGame;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedGame = 0;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: <Widget>[
        _featuredGamesWidget(),
        _gradientBoxWidget(),
        _topLayerWidget(),
      ]),
    );
  }

  Widget _featuredGamesWidget() {
    return SizedBox(
      height: _deviceHeight * 0.50,
      width: _deviceWidth,
      child: PageView(
        onPageChanged: (_index) {
          setState(() {
            _selectedGame = _index;
          });
        },
        scrollDirection: Axis.horizontal,
        children: featuredGames.map((_game) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_game.coverImage.url))),
          );
        }).toList(),
      ),
    );
  }

  Widget _gradientBoxWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _deviceHeight * 0.80,
        width: _deviceWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(35, 45, 59, 1.0),
            Colors.transparent,
          ], stops: [
            0.65,
            1.0
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
      ),
    );
  }

  Widget _topLayerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05, vertical: _deviceHeight * 0.005),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _topBarWidget(),
          SizedBox(height: _deviceHeight * 0.13,),
          _featuredGamesInfoWidget(),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
            child: ScrollableGameswidget(_deviceHeight * 0.24, _deviceWidth, games, true),
          ),
         _featuredGamesBannerWidget(),
          ScrollableGameswidget(_deviceHeight * 0.17, _deviceWidth, games2, false)
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return SizedBox(
      height: _deviceHeight * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(height: _deviceHeight * 0.1),
          Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: _deviceWidth * 0.03,
              ),
              Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featuredGamesInfoWidget() {
    return SizedBox(
      height: _deviceHeight * 0.15,
      width: _deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(

            maxLines: 2,
            featuredGames[_selectedGame].title,
            style: TextStyle(
              color: Colors.white,
              fontSize: _deviceHeight * 0.040,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((_game){
              bool _isActive = _game.title == featuredGames[_selectedGame].title;
              double _circleRadius = _deviceHeight * 0.004;
              return Container(
                margin: EdgeInsets.only(right: _deviceWidth * 0.015),
                height: _circleRadius * 2,
                width: _circleRadius * 2,
                decoration: BoxDecoration(

                  color: _isActive ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(100)
                ),

              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _featuredGamesBannerWidget(){
    return Container(
      height: _deviceHeight * 0.13,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(featuredGames[3].coverImage.url)),
      ),
    );
  }
}
