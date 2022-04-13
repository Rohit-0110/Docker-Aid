import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DockerCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final VoidCallback onPressed;
  const DockerCard(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            // handle your image tap here
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imgPath,
                  height: 70,
                  width: 70,
                ),
                Text(title,style: TextStyle(
                  fontSize: 18,fontFamily: "Changa",fontWeight: FontWeight.w900
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
