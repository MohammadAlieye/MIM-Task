import 'package:flutter/cupertino.dart';

import '../../constants/app_color.dart';

class StyleRefer {
  static const TextStyle kGilroy = TextStyle(
    fontFamily: UtilFonts.gilroy,
    overflow: TextOverflow.ellipsis,
    color: AppColor.kFont,
  );
  static const TextStyle kgilroyExtraBold = TextStyle(
    fontFamily: UtilFonts.gilroyExtraBold,
    overflow: TextOverflow.ellipsis,
    color: AppColor.kFont,
  );

  static const TextStyle kgilroySemiBold = TextStyle(
    fontFamily: UtilFonts.gilroySemiBold,
    overflow: TextOverflow.ellipsis,
    color: AppColor.kFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle gilroySemiBoldw500 = TextStyle(
    fontFamily: UtilFonts.gilroySemiBoldw500,
    overflow: TextOverflow.ellipsis,
    color: AppColor.kFont,
  );
  static const TextStyle gilroyBold = TextStyle(
    fontFamily: UtilFonts.gilroyBold,
    overflow: TextOverflow.ellipsis,
    color: AppColor.kFont,
  );
}

class UtilFonts {
  static const String gilroy = 'Gilroy';
  static const String gilroyBold = 'GilroyBold';
  static const String gilroyExtraBold = 'Gilroy-ExtraBold';
  static const String gilroySemiBold = 'Gilroy-SemiBold';
  static const String gilroySemiBoldw500 = 'Gilroy-SemiBoldw500';
}
