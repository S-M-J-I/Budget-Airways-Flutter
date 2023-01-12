import 'package:budget_airways/components/MyCard.dart';
import 'package:budget_airways/middlewares/APIMiddlewares.dart';
import 'package:budget_airways/middlewares/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/Flight.dart';

class FlightLists extends StatefulWidget {
  List<Flight> flights;
  String adults;
  String children;
  String infants;
  FlightLists({Key? key, required this.flights, required this.adults, required this.children, required this.infants}) : super(key: key);

  @override
  State<FlightLists> createState() => _FlightListsState();
}

class _FlightListsState extends State<FlightLists> {

  _bookNow(Flight flight) async {
    var url = "https://www.amadeus.net/results?cabinClass=Economy&country=BD&currency=BDT&locale=en&origin=${flight.start}&destination=${flight.dest}&outboundDate=${flight.departureDate}&adults=${widget.adults}&children=${widget.children}&infants=${widget.infants}";
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flights from ${widget.flights[0].start} to ${widget.flights[0].dest}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: widget.flights.length,
              itemBuilder: (context, index) {
                return MyCard(
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${widget.flights[index].start}"),
                              const SizedBox(width: 20.0,),
                              const Text("to"),
                              const SizedBox(width: 20.0,),
                              Text("${widget.flights[index].dest}"),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Text("${widget.flights[index].transit} transit", style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                      subtitle: Text("${widget.flights[index].price!.split(".")[0]} BDT"),
                      trailing: IconButton(
                        icon: const Icon(Icons.book, color: Colors.blue),
                        onPressed: () {
                          _bookNow(widget.flights[index]);
                        },
                      ),
                    )
                );
              }
          ),
        ),
      ),
    );
  }
}
