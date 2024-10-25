import 'package:flight_reservation/controllers/reserved_flight_history_controller.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/widgets/custom_scafold.dart';
import 'package:flight_reservation/widgets/item_flight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservedFlightHistoryScreen
    extends GetView<ReservedFlightHistoryController> {
  const ReservedFlightHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReservedFlightHistoryController());
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: "Reserved Flights History",
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/home.jpg'))),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1),
                    children: [
                      const TextSpan(text: 'Where are you\n'),
                      TextSpan(
                          text: 'flying',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary)),
                      const TextSpan(text: ' to?'),
                    ]),
              ),
            ),
          ),
          ListTile(
            title: Text('Reserved Flights',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: controller.reservedFlights.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => ReservedFlightCard(
                        flight: controller.reservedFlights[index],
                        onCancel: () {
                          controller.onRemoveClick(index);
                        },
                      ),
                    );
                  },
                )),
          ),
          Obx(() => CommonCode().showProgressIndicator(
              controller.isLoading.value, controller.reservedFlights.isEmpty))
        ],
      ),
      isDrawerVisible: true,
    );
  }
}
