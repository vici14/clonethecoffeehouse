import 'package:flutter/material.dart';

import 'my_colors.dart';

class FontFamily {
  static const String roboto = 'Roboto';
  static const String openSans = 'OpenSans';
}

class StylesText {
  static const light24GreyishBrown = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 24,
    color: MyColors.greyishBrown,
  );
  static const robotoRegular14Black38 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyColors.black38,
    fontFamily: FontFamily.roboto,
  );
  static const robotoRegular16Black87 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: MyColors.black87,
    fontFamily: 'OpenSans-Semibold',
  );

  static const regular16Black54 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: MyColors.black87,
  );
  static const regular14Black54 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyColors.black54,
  );

  static const regular14GreyishBrown = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyColors.greyishBrown,
  );
  static const bold14White = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: MyColors.white,
//    height: 18,
  );
}
