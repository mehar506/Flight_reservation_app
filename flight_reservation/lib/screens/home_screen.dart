import 'package:flight_reservation/controllers/home_controller.dart';
import 'package:flight_reservation/utils/common_code.dart';
import 'package:flight_reservation/utils/user_session.dart';
import 'package:flight_reservation/widgets/custom_scafold.dart';
import 'package:flight_reservation/widgets/item_flight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: " See Flights",
      scaffoldKey: GlobalKey<ScaffoldState>(),
      isDrawerVisible: true,
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
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                        blurRadius: 5,
                        spreadRadius: 5)
                  ]),
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.getFlights();
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter your destination',
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controller.onSearchClick();
                        },
                        child: const Icon(Icons.search, color: Colors.grey)),
                    prefixIcon: const Icon(Icons.location_on_outlined,
                        color: Colors.grey)),
              ),
            ),
          ),
          ListTile(
            title:
                Text('Flights', style: Theme.of(context).textTheme.titleLarge),
            trailing: TextButton(
              onPressed: () {},
              child: const Text(''),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemCount: controller.flights.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => ItemFlight(
                        flight: controller.flights[index],
                        onReserved: () {
                          controller.onBookClick(controller.flights[index]);
                        },
                        isReserved: controller.flights[index].reservedById ==
                            UserSession.passengerModel.value.id.toString()),
                  );
                },
              ),
            ),
          ),
           Obx(() => CommonCode().showProgressIndicator(
              controller.isLoading.value, controller.flights.isEmpty))
        ],
      ),
    );
  }
}
