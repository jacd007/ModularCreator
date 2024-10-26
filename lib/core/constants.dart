// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

const String APP_NAME = 'Viajes A';

/// Header base 64
///
/// return data:image/jpeg;base64,
const String headerBase64 = 'data:image/jpeg;base64,';

/// Key encrypt
const String keyEncrypt = 'keyEncrypt'; // Key encrypt

// ====================== Shared Preferences ======================
const String shared_isLogin = 'sharedIsLogin';
const String shared_JWT = 'sharedJWT';
const String shared_theme = 'sharedTheme';
const String shared_id = 'sharedIdCard';

/// ====================== Constants Project ======================
class Constants {
// ==================================================================
  static const String _assetsImg = 'assets/images';
  static const String _assetsIc = 'assets/icons';

// ====================== IMAGES ======================

  /// Logo and Icons APP
  static const String LOGO_BG = '$_assetsImg/bg.png';
  static const String LOGO = '$_assetsImg/icon.png';
  static const String LOGO_ICON2 = '$_assetsImg/icon2.png';
  static const String LOGO_TRANS2 = '$_assetsImg/icon_trans.png';

  /// icon page not found
  static const String imgPageNotFound = '$_assetsImg/not_found.png';

  /// Logo Splash
  static const String LOGO_SPLASH = '$_assetsImg/splash.png';

  /// avatar
  static const String LOGO_AVATAR = '$_assetsImg/ic_avatar.png';

  /// avatar trans
  static const String LOGO_AVATAR2 = '$_assetsImg/ic_avatar2.png';

  /// icon categories 2
  static const String iconCategories2 = '$_assetsImg/ic_categories.png';

  /// icon banner def
  static const String iconBannerDef = '$_assetsImg/banner.png';

  /// icon calendar gross, by designer
  static const String iconDialogCalendar = '$_assetsImg/ic_calendar.png';

  /// Images Onboarding
  // static const String onboarding1 = '$_assetsImg/onboarding/1.png';

// ====================== ICONS ======================

  /// icons menu
  static const String menu1 = '$_assetsIc/menu1.png';
  static const String menu2 = '$_assetsIc/menu2.png';
  static const String menu3 = '$_assetsIc/menu3.png';
  static const String menu4 = '$_assetsIc/menu4.png';
  static const String menu5 = '$_assetsIc/menu5.png';

  // icons app
  static const String iconArrowBack = "$_assetsIc/arrow_back.png";
  static const String iconArrowDouble = "$_assetsIc/arrow_double.png";
  static const String iconCall = "$_assetsIc/call.png";
  static const String iconFaceBook = "$_assetsIc/faceBook.png";
  static const String iconHome = "$_assetsIc/home.png";
  static const String iconPerson = "$_assetsIc/person.png";
  static const String iconPerson2 = "$_assetsIc/person2.png";
  static const String iconArrowDown = "$_assetsIc/arrow_down.png";
  static const String iconCarShop = "$_assetsIc/car_shop.png";
  static const String iconFavoriteEmpty = "$_assetsIc/favorite_empty.png";
  static const String iconInstagram = "$_assetsIc/instagram.png";
  static const String iconSearch = "$_assetsIc/search.png";
  static const String iconArrowNext = "$_assetsIc/arrow_next.png";
  static const String iconChat = "$_assetsIc/chat.png";
  static const String iconFavorite = "$_assetsIc/favorite.png";
  static const String iconMenu = "$_assetsIc/menu.png";
  static const String iconShared = "$_assetsIc/shared.png";
  static const String iconArrowUp = "$_assetsIc/arrow_up.png";
  static const String iconEmail = "$_assetsIc/email.png";
  static const String iconGrid = "$_assetsIc/grid.png";
  static const String iconNotification = "$_assetsIc/notification.png";
  static const String iconStart = "$_assetsIc/start.png";
  static const String iconCalendar = "$_assetsIc/calendar.png";
  static const String iconStartFill = "$_assetsIc/startFill.png";
  static const String iconStartHalf = "$_assetsIc/startHalf.png";
  static const String iconStartEmpty = "$_assetsIc/startEmpty.png";

// ====================== TEST ======================

  /// url image generics by index
  /// add `?sig=` plus a number
  /// Example:
  /// ```
  /// var url = "$urlUnsplash?sig=99";
  /// print(url); // output: https://source.unsplash.com/random?sig=99
  /// ```
  static const String urlUnsplash = 'https://source.unsplash.com/random';

  /// url image test
  static const String urlImageTest = '$urlUnsplash?sig=30';

  static String urlUnsplashId(int id) => '$urlUnsplash?sig=$id';

  static const String loremIpsum = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 

It was popularized in the 1960s with the release of Legraste sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Lauds PageMaker including versions of Lorem Ipsum.

Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClinton, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, connecter, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the uncountable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finis Bonum et Malory" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit ament..", comes from a line in section 1.10.32.
""";
}

// ==================================================================

///
/// [childAspectRatio] width / height
///
const aspectCard = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 180.0,
  mainAxisSpacing: 10.0,
  crossAxisSpacing: 10.0,
  childAspectRatio: 0.695,
);

const aspectCard2 = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 190.0,
  mainAxisSpacing: 5.0,
  crossAxisSpacing: 5.0,
  childAspectRatio: 4 / 5,
);

const crossAxisCount2 = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  childAspectRatio: 3 / 4,
);

const crossAxisCount = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 0.695,
);

const crossAxisSquareCount = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: 10.0,
  crossAxisSpacing: 10.0,
  childAspectRatio: 1 / 1,
);

const cross20AxisSquareCount = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: 12.0,
  crossAxisSpacing: 12.0,
  childAspectRatio: 0.85,
);

const aspectSquare = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 200,
  childAspectRatio: 1.0,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
);

const aspectRectRectangle = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 200.0,
  mainAxisSpacing: 10.0,
  crossAxisSpacing: 10.0,
  childAspectRatio: 5 / 3,
);
