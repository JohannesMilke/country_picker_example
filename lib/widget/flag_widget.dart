import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagWidget extends StatelessWidget {
  final String code;

  const FlagWidget({
    Key key,
    @required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlImage = 'assets/countries/$code.svg';

    return SvgPicture.asset(
      urlImage,
      height: 30,
      width: 30,
      fit: BoxFit.cover,
    );
  }
}
