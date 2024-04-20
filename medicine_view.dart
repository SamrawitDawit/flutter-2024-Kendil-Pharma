import 'package:flutter/material.dart';
import 'package:order_page/KendilAppBar.dart';
// void main() {
//   runApp(MaterialApp(home: MedicineView()));
// }
class MedicineView extends StatelessWidget {
  const MedicineView({
    super.key,
    this.medicineName,
    this.amount,
    this.composition,
    this.sideEffects,
    this.usage,
    this.price,
    this.is_user,
  });
  final String ? medicineName;
  final String ? amount;
  final String ? composition;
  final String ? sideEffects;
  final String ? usage;
  final int ? price;
  final bool ? is_user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(showBackArrow: true,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
            children: [
              Text(medicineName ?? 'Folic Acid Tablet', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 28),),
              SizedBox(height: 20,),
              Text(amount ?? '1 strip of 10 tablet', style: TextStyle(fontWeight: FontWeight.w300)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Divider(color: Colors.grey, thickness: 1.0, height: 1.0,),
              ),
              Container(child: Column(children: [
                Text('Composition', style: TextStyle(fontWeight: FontWeight.w300)),
                Text(composition ?? 'Amidipine(5mg) + Atenolol(50mg)', style: TextStyle(fontWeight: FontWeight.bold),)
              ],),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Divider(color: Colors.grey, thickness: 1.0, height: 1.0,),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Column(
                    children: [
                      Text('Side Effects', style: TextStyle(fontWeight: FontWeight.w300)),
                      Text(sideEffects ?? 'Sleepiness, Headache, Ankle swelling, Flushing(sense of warmth in the '
                          'face, ears, neck and trunk), Slow heart rate, Palpitations, Nausea, Edema,(swelling),'
                          'Constipation, Tiredness, Cold extremities', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Column(
                    children: [
                      Text('Usage guide', style: TextStyle(fontWeight: FontWeight.w300)),
                      Text(usage ?? 'Take this medicine in the dose and duration as advised by your doctor. '
                          'Swallow it as a hole. Do not chew, crush or break it. Betacard-AM 5mg/50mg Tablet is'
                          'to be taken empty stomach', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )

            ]
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: (
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Price: ETB${price ?? 100}'),
            if (is_user ?? true) // Use a default value of false if is_user is null
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_order');
                },
                child: Text('Order'),
              )
            else
              Row(children: [
                ElevatedButton(
                  onPressed: () {

                    // Add your edit button logic here
                  },
                  child: Text('Edit'),
                )],)

            ],
        )
        )
      ),
    );
  }
}
