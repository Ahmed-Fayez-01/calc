import 'package:flutter/material.dart';

class CustomAppBarTakesOperation extends StatelessWidget {
  const CustomAppBarTakesOperation({super.key,required this.merchantName});
final String merchantName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2b3396),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                )),
            const Text(
              "دفعت ل ",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo"),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                merchantName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
