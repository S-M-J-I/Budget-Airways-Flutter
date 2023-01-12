import 'package:budget_airways/components/MyCard.dart';
import 'package:flutter/material.dart';

import '../../models/Flight.dart';

class FlightLists extends StatefulWidget {
  List<Flight> flights;
  FlightLists({Key? key, required this.flights}) : super(key: key);

  @override
  State<FlightLists> createState() => _FlightListsState();
}

class _FlightListsState extends State<FlightLists> {

  _addToWatchList(flight) {

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
                return Card(
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
                              const SizedBox(width: 20.0,),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Text("${widget.flights[index].transit} transit", style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.watch_later, color: Colors.blue),
                        onPressed: () {
                          _addToWatchList(widget.flights[index]);
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
