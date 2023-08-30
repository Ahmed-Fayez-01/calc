import 'package:flutter/material.dart';


class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "باستخدام خدماتنا ، فإنك توافق على",
          // style: Styles.onboardingdescriptiontext()
          //     .copyWith(color: Color(0xff242B42)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Text(
                "الشروط",
                // style: Styles.onboardingdescriptiontext()
                //     .copyWith(
                //     color: AppColors.primaryColor,
                //     fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              " و ",
              // style: Styles.onboardingdescriptiontext(),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "سياسة الخصوصية",
                // style: Styles.onboardingdescriptiontext()
                //     .copyWith(
                //     color: AppColors.primaryColor,
                //     fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
