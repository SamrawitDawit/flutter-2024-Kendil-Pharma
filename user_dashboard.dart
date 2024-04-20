import 'package:flutter/material.dart';
import 'package:flutter_application_1/medicine_view.dart';
import 'package:flutter_application_1/KendilAppBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const KendilAppBar(
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                padding: EdgeInsets.all(5),
                child: Image.asset('assets/Kendil pharma.png'),
              ),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/slider-bg.jpg',
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      left: 30,
                      right: 10,
                      bottom: 0,
                      child: Center(
                        child: Text(
                          'Unleash The Boundless World of Drugs and Medication for Informed Wallness Exploration!!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 7.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicineView()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Color.fromARGB(255, 204, 25, 13)
                            .withOpacity(0.6);
                      return Color.fromARGB(255, 10, 158, 17);
                    }),
                  ),
                  child: const Text(
                    'VIEW DRUGS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 170,
                color: Color.fromARGB(255, 54, 135, 201),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: const Text(
                                'Contact Us',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    '+25370923641',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'abfh56sv@gmail.com',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          children: [
                            Text(
                              'Follow as on',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.whatshot,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                Icon(
                                  Icons.facebook,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                Icon(
                                  Icons.telegram,
                                  size: 30,
                                  color: Colors.green,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    const Center(
                      child: Text(
                        '2024 Kendil pharma alright to reserve',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
