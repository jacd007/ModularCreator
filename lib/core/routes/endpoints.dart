// ignore_for_file: constant_identifier_names

const String url_base = "https://api.hojadevida.digital";

const String header_json = 'application/json; charset=UTF-8';
const String header_formData = 'application/x-www-form-urlencoded';

/// privacy politics
const String linkPrivacy = "https://api.hojadevida.digital/";

/// link support help
const String linkHelp = 'https://api.hojadevida.digital/';

/// link main Shop
const String linkShop = 'https://api.hojadevida.digital/';

/// uri google
final Uri uriGoogle = Uri.parse('https://google.com');

// ...

class Endpoint {
  Endpoint._();

  /// endpoint login
  static const String login = '/signin';

  /// endpoint login to Get user, required [token]
  static const String user = '/api/v1/user';

  /// endpoint person, required [token]
  static const String people = '/api/v1/people';

  /// endpoint register
  static const String signUp = '/signup';

  /// endpoint profile, required [token]
  static const String profile = '/api/v1/profile';

  /// endpoint login to Get offers, required [token]
  static const String offers = '/api/v1/offer';

  /// endpoint Country
  static const String country = '/country';

  /// endpoint City
  static const String city = '/city';

  /// endpoint status, required [token]
  static const String status = '/api/v1/status';

  /// endpoint service, required [token]
  static const String service = '/api/v1/service';

  /// endpoint Company, required [token]
  static const String company = '/api/v1/company';

  /// endpoint Category Company, required [token]
  static const String categoryCompany = '/api/v1/categoryCompany';
}
