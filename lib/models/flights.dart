class Flight {
  final String flightId;
  final String src;
  final String des;
  final String departureTime;
  final String arrivalTime;
  final List<double> srcCoordinates;
  final List<double> desCoordinates;
  final int passengerCapacity;
  final int bookedPassengers;

  Flight({
    required this.flightId,
    required this.src,
    required this.des,
    required this.departureTime,
    required this.arrivalTime,
    required this.srcCoordinates,
    required this.desCoordinates,
    required this.passengerCapacity,
    required this.bookedPassengers,
  });
}
