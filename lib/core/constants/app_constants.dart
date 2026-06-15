class AppConstants {
  AppConstants._();

  // Supabase — заменить на свои значения из проекта Supabase
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Лимиты Free-тарифа
  static const int freeIdeasPerDay = 5;
  static const int freeSavedIdeas = 10;

  // Тарифы
  static const int proMonthlyPrice = 499;
  static const int proYearlyPrice = 3490;
  static const int proLaunchPrice = 199;

  // Токены AI
  static const int ideaMaxTokens = 150;
  static const int script15sTokens = 100;
  static const int script30sTokens = 250;
  static const int script60sTokens = 500;
  static const int contentPlanMaxTokens = 2000;
}
