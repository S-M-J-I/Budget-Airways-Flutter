import 'package:budget_airways/components/CardTitle.dart';
import 'package:budget_airways/components/MyCard.dart';
import 'package:budget_airways/middlewares/APIMiddlewares.dart';
import 'package:budget_airways/models/Flight.dart';
import 'package:budget_airways/screens/HomeScreens/FlightLists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../middlewares/Dialogs.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _childController = TextEditingController();
  final TextEditingController _infantsController = TextEditingController();

  List<String> list = <String>['DAC', 'IST', 'NYC', 'DXB', 'TOR'];
  String? _startAir = 'DAC';
  String? _destAir = 'DAC';
  String? _selectedDate;

  _searchFlights() async {
    print(
        "$_startAir, $_destAir, $_selectedDate, ${_adultsController.value.text}, ${_childController.value.text}, ${_infantsController.value.text}"
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Text("Loading"),
              ],
            ),
          ),
        );
      },
    );


    try {
      List<Flight> res = await APIMiddlewares().getFlights(path: "flights/getflightoffers", details: <String, String>{
        "start": _startAir!,
        "dest": _destAir!,
        "departureDate": _selectedDate!,
        "adults": _adultsController.value.text,
        "children": _childController.value.text,
        "infants": _infantsController.value.text
      });
      // print(res[0].airlines);
      Navigator.pop(context);

      Navigator.push(context,
        MaterialPageRoute(builder: (context) => FlightLists(flights: res))
      );
    } catch(error) {
      Navigator.pop(context);

      Dialogs d = Dialogs();
      d.showWarningDialog(error, context);
    }
  }

  _clear() {

  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CardTitle(title: "Search"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Start"),
                      const SizedBox(width: 10.0),
                      DropdownButton(
                        value: _startAir,
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _startAir = value.toString();
                          });
                        },
                      ),
                    ],
                  )
              ),
              const SizedBox(width: 20,),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Destination"),
                      const SizedBox(width: 10.0),
                      DropdownButton(
                        value: _destAir,
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _destAir = value.toString();
                          });
                        },
                      ),
                    ],
                  )
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _adultsController,
                  decoration: const InputDecoration(
                    labelText: "Adults",
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _childController,
                  decoration: const InputDecoration(
                      labelText: "Children",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _infantsController,
                  decoration: const InputDecoration(
                      labelText: "Infants",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2030),
                  );

                  if(newDate != null) {
                    setState(() {
                      _selectedDate = newDate!.toIso8601String().split("T")[0];
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Selected $_selectedDate")));
                  }
                },
                child: const Text("Select Departure Date")
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: ElevatedButton(
                    onPressed: _searchFlights,
                    child: const Text(
                      "Search Flights"
                    )
                ),
              ),
              const SizedBox(width: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: OutlinedButton(
                    onPressed: _clear,
                    child: const Text(
                        "Clear"
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
