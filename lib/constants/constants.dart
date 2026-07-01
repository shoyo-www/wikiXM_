
class Constants {
  static const responseError = 'ERROR';
  static const responseSuccess = 'SUCCESS';
  static const someThingWentWrong = 'Something went wrong.';
  static const reCaptchaSiteKey = '6LdpybgmAAAAAISLIzZ5Orj6922divJgT3_EeYJh';
}

class GetXStorageConstants {
  static const authToken = "Authorization";
  static const darkTheme = "DarkTheme";
  static const townName = "TownName";

}

class ControllerBuilders {
  static String homeController = 'HomeController';
  static String homeSectionsController = 'HomeSectionsController';
  static String searchTownController = 'SearchTownController';

}

class ApiStatus {
  static const success = "1";
  static const failed = "Failed";
}

class FontFamily {
  static const poppins = 'Poppins';
}

class MenuItem {
  final String name;
  final String image;
  
  MenuItem({required this.name,required this.image});
}

class DateFormats {
  static String yyyyMMddWithDash = 'YYYY-MM-dd';
  static String ddMMMWithSpace = 'dd MMM';
  static String eeeDdMMMyyyy = 'EEEE dd MMM yyyy';
  static String ddMMMyyyy = 'dd MMM yyyy';
  static String eDDMMM = 'E, dd MMM';
  static String hhmma = 'hh:mm a';
  static String month = 'MMMM';
  static String eeeee = 'EEEEE';
}

