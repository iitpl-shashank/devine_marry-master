import 'package:flutter/cupertino.dart';

import '../../../utils/images.dart';

class ProfileCompleteScreen extends StatelessWidget {
  const ProfileCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
     image: DecorationImage(image: AssetImage(Images.successRegistration))
      ),
    );
  }
}
