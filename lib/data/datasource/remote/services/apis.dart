class Apis {
  static const baseUrl = 'https://staging.wikixm.com/api/mobile/v1';
  static const login = '$baseUrl/login';
  static const register = '$baseUrl/register';
  static const verifyOtp = '$baseUrl/verify-otp';
  static const resendOtp = '$baseUrl/resend-otp';
  static const home = '$baseUrl/home';
  static const communityHome = '$baseUrl/home/community';
  static const homeInterests = '$baseUrl/v1/home/interest-sections';
  static const homeLocal = '$baseUrl/v1/home/local-sections';
  static const weather = '$baseUrl/home/weather';
  static const notification = '$baseUrl/notification/get?per_page=10&page=';
  static const searchTowns = '$baseUrl/cities/search';
  static const saveCities = '$baseUrl/register/community';
  static const suggestedTown = '$baseUrl/cities/{city_id}/suggestions';
  static const homeInsights = '$baseUrl/home/insights';
  static const homeMarketPlace = '$baseUrl/home/marketplace';
  static const personalisation = '$baseUrl/register/personalization';
  static const completeRegistration = '$baseUrl/register/complete';
  static const sportsSection = '$baseUrl/sports';
  static const weatherHero = '$baseUrl/weather/46820/hero';
  static const weatherCards = '$baseUrl/weather/46820/cards';
  static const alerts = '$baseUrl/weather/46820/alerts';
  static const communityOverview = '$baseUrl/community/intelligence/overview';
  static const communityFeed = '$baseUrl/community/intelligence/feed';
  static const education = '$baseUrl/education/home';
  static const entertainment = '$baseUrl/entertainment/home';
  static const politics = '$baseUrl/politics/home';
  static const commandCenter = '$baseUrl/civic-command-center/home';
  static const townHall = '$baseUrl/town-hall/home';
}

