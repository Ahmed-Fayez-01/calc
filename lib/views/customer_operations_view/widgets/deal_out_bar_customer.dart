import 'package:flutter/material.dart';

class DealOutBar extends StatelessWidget {
  const DealOutBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                "المعاملات",
                style: TextStyle(
                    color: Color(0xff2b3396),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo"),
              )),
          Expanded(
              flex: 1,
              child: Text(
                "اعطيت",
                style: TextStyle(
                    color: Color(0xff2b3396),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo"),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "حصلت",
                style: TextStyle(
                    color: Color(0xff2b3396),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo"),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
