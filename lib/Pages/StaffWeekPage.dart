import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_core/Models/Menu.dart';
import 'package:hansenberg_app_core/Utilities/Clients/MenuClient.dart';
import 'package:hansenberg_app_core/Utilities/MaterialWeekNavigator.dart';
import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';
import 'package:hansenberg_app_core/Utilities/util.dart';
import 'package:hansenberg_app_core/Widgets/ActivityIndicatorWithTitle.dart';
import 'package:hansenberg_app_web/Widgets/DayColumn.dart';
import 'package:hansenberg_app_web/Widgets/FridayColumn.dart';
import 'package:hansenberg_app_web/Widgets/PaddedContainer.dart';
import 'package:week_of_year/date_week_extensions.dart';

class StaffWeekPage extends StatefulWidget {
  const StaffWeekPage({Key? key, required this.mondayOfWeek, required this.menuClient, required this.tokenStorage, required this.weekNavigator}) : super(key: key);

  final DateTime mondayOfWeek;
  final MenuClient menuClient;
  final TokenStorage tokenStorage;
  final MaterialWeekNavigator weekNavigator;

  @override
  State<StaffWeekPage> createState() => _StaffWeekPageState();
}

class _StaffWeekPageState extends State<StaffWeekPage> {

  late TextEditingController _mondayMenuController;
  late TextEditingController _tuesdayMenuController;
  late TextEditingController _wednesdayMenuController;
  late TextEditingController _thursdayMenuController;

  @override
  void initState() {
    super.initState();
    _mondayMenuController = TextEditingController();
    _tuesdayMenuController = TextEditingController();
    _wednesdayMenuController = TextEditingController();
    _thursdayMenuController = TextEditingController();
  }

  @override
  void dispose() {
    _mondayMenuController.dispose();
    _tuesdayMenuController.dispose();
    _wednesdayMenuController.dispose();
    _thursdayMenuController.dispose();
    super.dispose();
  }

  Menu _menu = Menu(monday: "", tuesday: "", wednesday: "", thursday: "");

  Future<bool> _fetchData() async {
    print("Fetching data!");
    try {
      Menu? menu = await widget.menuClient.getMenu(widget.mondayOfWeek.year, widget.mondayOfWeek.weekOfYear);

      if (menu != null) {
        _menu = menu;
        return true;
      }
      else {
        //TODO: Notification
      }
    }
    catch(e) {
      print(e.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      builder: (BuildContext futureContext, AsyncSnapshot<bool> snapshot) {
        Widget child;

        if (snapshot.hasData) {
          child = _createPage();
        }
        else if (snapshot.hasError) {
          child = Center(child: Text("$snapshot.error"),);
        }
        else {
          child = const ActivityIndicatorWithTitle();
        }

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
                IconButton(
                    onPressed: _canNavigate ? () => widget.weekNavigator.toPreviousWeek() : null,
                    icon: Icon(Icons.arrow_back_ios)
                ),
                Text("Uge ${widget.mondayOfWeek.weekOfYear}"),
                IconButton(
                    onPressed: _canNavigate ? () => widget.weekNavigator.toNextWeek() : null,
                    icon: Icon(Icons.arrow_forward_ios)
                ),
              ],
            ),
          ),
          body: child,
        );
      },
      future: _fetchData(),
    );
  }

  bool get _canNavigate {
    return true;
  }

  Widget _createPage() {
    var dates = List<DateTime>.generate(5, (index) => widget.mondayOfWeek.add(Duration(days: index)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 55,
          ),
          decoration: const BoxDecoration(color: Colors.blueAccent),
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
                  DayColumn(
                    dateString: "${dayNumberInWeekToDayString(dates[0].weekday)} d. ${dates[0].day} ${monthNumberToMonthString(dates[0].month)}",
                    menuString: _menu.toList()[0],),
                  DayColumn(
                    dateString: "${dayNumberInWeekToDayString(dates[1].weekday)} d. ${dates[1].day} ${monthNumberToMonthString(dates[1].month)}",
                    menuString: _menu.toList()[1],),
                  DayColumn(
                    dateString: "${dayNumberInWeekToDayString(dates[2].weekday)} d. ${dates[2].day} ${monthNumberToMonthString(dates[2].month)}",
                    menuString: _menu.toList()[2],),
                  DayColumn(
                    dateString: "${dayNumberInWeekToDayString(dates[3].weekday)} d. ${dates[3].day} ${monthNumberToMonthString(dates[3].month)}",
                    menuString: _menu.toList()[3],),
                  FridayColumn(dateString: "Fredag", enlistedNumber: 30,)
                ],
              )
            ],
          ),
        ),
        const Spacer()
      ],
    );
  }
}
