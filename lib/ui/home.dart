import 'package:base64/ui/pages/decode.dart';
import 'package:base64/ui/pages/encode.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itemList = ["Endcode", "Decode"];

  int itemIndex = 0;

  List itemPage = [Endcode(), Decode()];

  @override
  Widget build(BuildContext context) {
    Widget tabBarItem(int index) {
      return Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              itemIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 750),
            curve: Curves.bounceInOut,
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: itemIndex == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                itemList[index],
                style: TextStyle(
                    color: itemIndex == index ? Colors.blue : Colors.white),
              ),
            ),
          ),
        ),
      );
    }

    Widget tabBar() {
      return Container(
        decoration: BoxDecoration(
            color: Colors.blue[700], borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            tabBarItem(0),
            tabBarItem(1),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: tabBar(),
          automaticallyImplyLeading: false,
        ),
        body: itemPage.elementAt(itemIndex));
  }
}
