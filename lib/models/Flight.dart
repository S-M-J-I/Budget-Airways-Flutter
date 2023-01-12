class Flight{
  String? start;
  String? dest;
  String? departureDate;
  String? transit;
  String? airlines;
  String? price;

  Flight(this.start, this.dest, this.departureDate, this.transit, this.airlines,
      this.price);

  Flight.fromJson(Map<String, dynamic> json) {
    start = json["itineraries"][0]["segments"][0]["departure"]["iataCode"];
    transit = json["itineraries"][0]["segments"][0]["arrival"]["iataCode"];
    dest = json["itineraries"][0]["segments"][1]["arrival"]["iataCode"];
    departureDate = json["lastTicketingDate"];
    airlines = json["itineraries"][0]["segments"][0]["carrierCode"];
    price = "${json["price"]["total"]} ${json["price"]["currency"]}";
  }

}