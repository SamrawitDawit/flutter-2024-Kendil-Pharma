import 'package:flutter/material.dart';


class PharmaPageBody extends StatefulWidget {
  const PharmaPageBody({super.key});

  @override
  State<PharmaPageBody> createState() => _PharmaPageBodyState();
}

class _PharmaPageBodyState extends State<PharmaPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: PageView.builder(
        itemCount: 8,
        itemBuilder: (context, position){
          return _buildPageItem(position);
      }),
    );
  }
  Widget _buildPageItem(int index){

    List<String> imageCollection = [
      'assets2/oil.jpeg',
      'assets3/pic6.jpeg',
      'assets2/coughhsyrup.jpeg',
      'assets2/Lotion.jpeg',
      'assets2/legbone.jpeg',
      'assets3/pic7.jpeg',
      'assets2/cosmetic.jpeg',
      'assets2/baby3.jpeg',
      
    ];

    List<String> texts = [
      'Text 1',
      'Text 2',
      'Text 3',
      'Text 4',
      'Text 5',
      'Text 5',
      'Text 5',
      'Text 5',
    ];

    return Column(
      children: [
        Container(
          height: 235,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: index.isEven?Colors.pinkAccent : Colors.greenAccent,
            image: DecorationImage(
              image: AssetImage(imageCollection[index]),
              fit: BoxFit.cover
              ),
            boxShadow: [
             BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
          ),
          child: Center(
            child: Text(
              texts[index],
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),

        
      ],
    );
  }
}