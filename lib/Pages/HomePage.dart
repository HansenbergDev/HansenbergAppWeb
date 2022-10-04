import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_web/Widgets/DayColumn.dart';
import 'package:hansenberg_app_web/Widgets/FridayColumn.dart';
import 'package:hansenberg_app_web/Widgets/PaddedContainer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {},
      ),
      drawer: Drawer(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration:
                    BoxDecoration(color: CupertinoColors.systemBackground),
                child: Text("Drawer header")),
            ListTile(
              title: const Text("Item 1"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
            Text("Uge 37"),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 55,
            ),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          const Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
                    PaddedContainer(
                      backgroundColor: CupertinoColors.systemBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Indskrevne: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "237",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    PaddedContainer(
                      backgroundColor: CupertinoColors.systemBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Registrerede: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "109",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DayColumn(dateString: "Mandag", menuString: "Det her er en menu, som forhåbentligt fylder mere end bare en enkelt linje",),
                    DayColumn(dateString: "Tirsdag",),
                    DayColumn(dateString: "Onsdag",),
                    DayColumn(dateString: "Torsdag",),
                    FridayColumn(dateString: "Fredag", enlistedNumber: 30,)
                  ],
                )
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
