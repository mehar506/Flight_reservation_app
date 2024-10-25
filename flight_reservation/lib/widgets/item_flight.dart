// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flight_reservation/models/flight_model.dart';
import 'package:flight_reservation/models/reserve_model.dart';
import 'package:flight_reservation/utils/styles/colors.dart';

class ItemFlight extends StatelessWidget {
  final FlightModel flight;
  final Function()? onReserved;
  final bool isReserved;
  const ItemFlight({
    Key? key,
    required this.flight,
    this.onReserved,
    required this.isReserved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                blurRadius: 5,
                spreadRadius: 5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(flight.departureTime),
                ),
                const SizedBox(height: 25),
                Text(
                  flight.departureCity.substring(0, 3).toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.flight_takeoff),
                    Text(
                      flight.flightNo,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onReserved,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: isReserved
                            ? Colors.green.withOpacity(.5)
                            : AppColor.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      isReserved ? 'Reserved' : 'Reserve Now',
                      style: TextStyle(
                        color: isReserved ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(flight.arrivalTime)),
                const SizedBox(height: 25),
                Text(flight.arrivalCity.substring(0, 3).toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, letterSpacing: 2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ReservedFlightCard extends StatelessWidget {
  final ReserveModel flight;
  final Function()? onCancel;
  const ReservedFlightCard({
    Key? key,
    required this.flight,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                blurRadius: 5,
                spreadRadius: 5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 'date: ${flight.date.toString()}'
                ),
                const SizedBox(height: 5),
               Text(
                 'Seat Number: ${flight.id.toString().substring(9, 11)}'
                ),
                const SizedBox(height: 5),
                Text(
                 'Price: ${flight.price.toString()}'
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                const Icon(Icons.flight_takeoff),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Cancel Now',
                      style: TextStyle(
                        color:  Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


