import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlightCard extends StatelessWidget {
  FlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Source",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 206, 161),
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Delhi",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Destination",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 206, 161),
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Pune",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            color: Color.fromARGB(255, 154, 154, 154),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2/03/2024",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Flight No",
                        style: TextStyle(
                            color: Color.fromARGB(255, 154, 154, 154),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "6E 1234",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: 70,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border(top: BorderSide(color: Colors.white, width: 1)),
          ),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.flight_takeoff,
                  size: 25,
                  color: Theme.of(context).indicatorColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "35 Mins",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
