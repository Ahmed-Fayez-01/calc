import 'package:flutter/material.dart';

class CustomAppBarPayOperation extends StatelessWidget {
  const CustomAppBarPayOperation({super.key});

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
            const SizedBox(
              width: 5,
            ),
            const Expanded(
              child: Text(
                " احمد فايز عبدالفتاح",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo"),
              ),
            ),
            const Text(
              "حصلت منه",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo"),
            ),
          ],
        ),
      ),
    );
  }
}
