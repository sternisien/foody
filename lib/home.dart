// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/enum/month.dart';
import 'package:foody/services/data_service.dart';

import 'home_card.dart';
import 'model/food.dart';

//A partir de cette définition global propriétés et widget à builder. Le runtime sait quelle propriété utilisé
//et quel type de Widget il faut retourner pour l'affichage à l'App au niveau de main.dart (ici un Scaffold)
class Home extends StatefulWidget {
  String _title;
  final List<Month> listMonth = Month.values;

  Home({Key? key, required String title})
      : _title = title,
        super(key: key);

  String getTitle() {
    return _title;
  }

  void setTitle(String title) {
    _title = title;
  }

  // L'état _HomeState contient l'instance Home effectuer dans main.dart et permet de généré l'affichage
  //(Widget) à partir des données assignées aux attributs de Home. L'instance de Home est assignée à la variable T? _widget
  // par conséquent T? _widget est une variable de référence.
  @override
  _HomeState createState() => _HomeState();
}

//L'état sait que le widget est de type Home (T get widget => _widget! = Home get widget => _widget! ici
//et  T? _widget = Home? _widget) : Ce qui donne accés aux attributs définis dans l'objet dans la partie State.
//Lors de l'instanciation de Home (coté main.dart) => createState va etre invoqué pour créer l'instance del'état (_HomeState)
//et cette instance Home va etre associée à cette instance d'état et stockée dans l'attribut (widget => _widget!).
//Toutes modifications passe par la classe d'état et nécessit un rebuild du context par la fonction build().
//L'attribut _widget contenant l'instance Home, ici, n'est accessible que en lecture (T get widget => _widget!), il est impossible d'effectuer des modifications directement.
//Pour effectuer des modifications il faut passer par les setter de l'instance de l'objet T? _widget = Home? _widget.
//Le fonctionnement par reference permet à l'état _HomeState d'etre au courant de chaque modification et de rebuild le context
//par la fonction build() avec les nouvelles valeurs, ici nous pouvons voir que l'instance effectuer coté main.dart correspond à celle assignée
//dans l'attrbut _widget, héritée par l'abstract class State, dans la classe _HomeState:
//flutter: in main.dart 976399325 (hascode de l'instance effectuer)
//flutter: in State<Home> : 976399325 (hascode de l'objet assignée à T? _widget (variable de référence))
class _HomeState extends State<Home> {
  final DataService? _dataService = DataService.getInstance();
  List<Food> foodList = [];
  int selectedIndex = 2;
  bool isTabBar = true;
  @override
  void initState() {
    //permet de vérifier l'état du widget vu qu'on surcharge certe méthode on perd le comportement initial puisque c'est notre code qui
    //sera executé, on force dont le check(force le check)
    //important checker le lifecycle pour vérifier que le statut du widget est à créer quand la fonction est exécuté
    //initState : appelé une fois à l'init -> donc statut created, à l'entrée de la fonction ,lors de l'exec, et initialized à la sortie.
    //Si on essaye d'appeler cette fonction, plus tard, dans la classe lors d'un event (click) par exemple une error remontera car
    //l'état du widget ne sera plus au statut created
    super.initState();
  }

  //Wait for data
  //FutureBuilder(
  //future: _dataService!.getFood(),
  //);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.listMonth.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffe8f5e9),
          centerTitle: true,
          bottom: PreferredSize(
            child: getTabBarOrSearchBar(isTabBar),
            preferredSize: Size.fromHeight(30.0),
          ),
          actions: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.swap_horizontal_circle_rounded,
                      color: Color(0xff027353),
                    ),
                    onTap: () {
                      setState(() {
                        //on tap isTabBar = true switch to false search bar appear otherwise onTap isTabBar
                        // false switch to true chips appear
                        isTabBar = isTabBar ? false : true;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: _dataService!.getFood(),
          builder: (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.75,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: getCards(snapshot),
              );
            }
          },
        ),
      ),
    );
  }

  List<HomeCard> getCards(AsyncSnapshot<List<Food>> snapshot) {
    if (snapshot.data == null) {
      return [];
    }

    List<HomeCard> cards = [];
    for (var element in snapshot.data!) {
      cards.add(HomeCard(
        food: element,
      ));
    }

    return cards;
  }

  List<GestureDetector> getChipsMonth(List<Month> months, int selectIndex) {
    List<GestureDetector> myChips = [];

    for (var i = 0; i < months.length; i++) {
      String textChip = months[i].toString().split(".")[1].toUpperCase();
      GestureDetector gestureChip = GestureDetector(
        onTap: () {},
        child: ChoiceChip(
          selected: i == selectIndex,
          selectedColor: Color(0xff0588A6),
          label: Text(
            textChip,
            style: TextStyle(
              color: Color(0xffe8f5e9),
            ),
          ),
          backgroundColor: Color(0xff027353),
          onSelected: (select) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      myChips.add(gestureChip);
    }
    return myChips;
  }

  Widget getTabBarOrSearchBar(bool isTabBar) {
    Widget widgetToReturn;
    if (isTabBar) {
      widgetToReturn = TabBar(
        labelPadding: EdgeInsets.all(5),
        indicatorColor: Colors.transparent,
        isScrollable: true,
        unselectedLabelColor: Colors.white.withOpacity(0.3),
        tabs: getChipsMonth(widget.listMonth, selectedIndex),
      );
    } else {
      widgetToReturn = CupertinoSearchTextField(
        padding: EdgeInsetsDirectional.all(10),
        backgroundColor: Color(0xffe8f5e9),
        itemColor: Color(0xff027353),
        controller: TextEditingController(text: 'initial text'),
        onChanged: (text) {
          print(text);
        },
      );
    }

    return widgetToReturn;
  }
}
