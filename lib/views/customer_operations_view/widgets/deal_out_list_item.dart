import 'package:flutter/material.dart';

class DealOutListItem extends StatelessWidget {
  const DealOutListItem({super.key,required this.transaction});
  final Map<String,dynamic> transaction;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            // height: height / 4.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffd9d9d9)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "${transaction["timestamp"]}",
                            style: const TextStyle(fontFamily: "Cairo"),
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          transaction["price"]>0? "${ transaction["price"]}":"",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xffce527a),
                              fontFamily: "Cairo"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          transaction["price"] <0 ? "${transaction["price"]*-1}":"",
                          style: const TextStyle(
                              color: Color(0xff5c6ab3),
                              fontFamily: "Cairo"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  transaction["description"]!=""?Text(
                    transaction["description"],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo"),
                  ):const SizedBox(),
                  SizedBox(
                    height:transaction["description"]!=""? height * .02:0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffdbe3ff),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "الرصيد",
                        style: TextStyle(fontFamily: "Cairo"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
    // : Color(0xfffdd8e9),