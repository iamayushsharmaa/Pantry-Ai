import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('hi')
  ];

  /// No description provided for @home_appTitle.
  ///
  /// In en, this message translates to:
  /// **'PANTRY AI.'**
  String get home_appTitle;

  /// No description provided for @cook_smart_with_ai.
  ///
  /// In en, this message translates to:
  /// **'Cook smart with AI'**
  String get cook_smart_with_ai;

  /// No description provided for @home_tagline.
  ///
  /// In en, this message translates to:
  /// **'Scan and make recipe suggestions with AI.'**
  String get home_tagline;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @auth_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_email;

  /// No description provided for @auth_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get auth_name;

  /// No description provided for @auth_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get auth_enter_name;

  /// No description provided for @auth_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// No description provided for @auth_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get auth_signIn;

  /// No description provided for @auth_enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get auth_enterEmail;

  /// No description provided for @auth_enterValid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get auth_enterValid_email;

  /// No description provided for @auth_enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get auth_enterPassword;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 6 chars'**
  String get password_hint;

  /// No description provided for @auth_signInLink.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get auth_signInLink;

  /// No description provided for @auth_signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get auth_signInButton;

  /// No description provided for @auth_signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get auth_signUpLink;

  /// No description provided for @auth_signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get auth_signUpButton;

  /// No description provided for @auth_signUp.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get auth_signUp;

  /// No description provided for @auth_google_signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get auth_google_signingIn;

  /// No description provided for @auth_google_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get auth_google_continue;

  /// No description provided for @auth_email_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get auth_email_continue;

  /// No description provided for @scan_ingredient.
  ///
  /// In en, this message translates to:
  /// **'Scan Ingredients'**
  String get scan_ingredient;

  /// No description provided for @scan_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap to scan your pantry or\nupload a photo'**
  String get scan_hint;

  /// No description provided for @start_scanning.
  ///
  /// In en, this message translates to:
  /// **'Start scanning'**
  String get start_scanning;

  /// No description provided for @searching_recipes.
  ///
  /// In en, this message translates to:
  /// **'Search recipes...'**
  String get searching_recipes;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @enable_dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme'**
  String get enable_dark_theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation;

  /// No description provided for @delete_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account permanently?'**
  String get delete_confirmation;

  /// No description provided for @added_to_cooking.
  ///
  /// In en, this message translates to:
  /// **'Added to cooking'**
  String get added_to_cooking;

  /// No description provided for @add_to_cooking.
  ///
  /// In en, this message translates to:
  /// **'Add to cooking'**
  String get add_to_cooking;

  /// No description provided for @removed_from_cooking_list.
  ///
  /// In en, this message translates to:
  /// **'Removed from cooking list'**
  String get removed_from_cooking_list;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @no_favorites_yet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get no_favorites_yet;

  /// No description provided for @add_to_favorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get add_to_favorites;

  /// No description provided for @remove_from_favorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get remove_from_favorites;

  /// No description provided for @recipe.
  ///
  /// In en, this message translates to:
  /// **'recipe'**
  String get recipe;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'recipes'**
  String get recipes;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @found.
  ///
  /// In en, this message translates to:
  /// **'found'**
  String get found;

  /// No description provided for @edit_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile_title;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get app_settings;

  /// No description provided for @quick_recipes_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Quick recipes coming soon'**
  String get quick_recipes_coming_soon;

  /// No description provided for @generate_recipes_to_see_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Generate recipes to see suggestions'**
  String get generate_recipes_to_see_suggestions;

  /// No description provided for @no_recipes_generated_yet.
  ///
  /// In en, this message translates to:
  /// **'No recipes generated yet'**
  String get no_recipes_generated_yet;

  /// No description provided for @scan_your_pantry_to_get_started.
  ///
  /// In en, this message translates to:
  /// **'Scan your pantry to get started'**
  String get scan_your_pantry_to_get_started;

  /// No description provided for @recently_generated.
  ///
  /// In en, this message translates to:
  /// **'Recently Generated'**
  String get recently_generated;

  /// No description provided for @your_latest_recipe_discoveries.
  ///
  /// In en, this message translates to:
  /// **'Your latest recipe discoveries'**
  String get your_latest_recipe_discoveries;

  /// No description provided for @quick_and_easy.
  ///
  /// In en, this message translates to:
  /// **'Quick & Easy'**
  String get quick_and_easy;

  /// No description provided for @recipes_under_30_minutes.
  ///
  /// In en, this message translates to:
  /// **'Recipes under 30 minutes'**
  String get recipes_under_30_minutes;

  /// No description provided for @scan_a_recipe.
  ///
  /// In en, this message translates to:
  /// **'Scan a recipe'**
  String get scan_a_recipe;

  /// No description provided for @no_recipe_found.
  ///
  /// In en, this message translates to:
  /// **'No Recipe Found'**
  String get no_recipe_found;

  /// No description provided for @try_adjusting_filters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get try_adjusting_filters;

  /// No description provided for @savedRecipes.
  ///
  /// In en, this message translates to:
  /// **'Saved Recipes'**
  String get savedRecipes;

  /// No description provided for @ingredients_title.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients_title;

  /// No description provided for @missing_ingredients_title.
  ///
  /// In en, this message translates to:
  /// **'Missing Ingredients'**
  String get missing_ingredients_title;

  /// No description provided for @cooking_instructions.
  ///
  /// In en, this message translates to:
  /// **'Cooking Instructions'**
  String get cooking_instructions;

  /// No description provided for @taste_preference_title.
  ///
  /// In en, this message translates to:
  /// **'Taste Preferences'**
  String get taste_preference_title;

  /// No description provided for @how_would_you_like_to_taste.
  ///
  /// In en, this message translates to:
  /// **'How would you like the taste?'**
  String get how_would_you_like_to_taste;

  /// No description provided for @which_cuisine_do_you_prefer.
  ///
  /// In en, this message translates to:
  /// **'Which cuisine do you prefer?'**
  String get which_cuisine_do_you_prefer;

  /// No description provided for @whats_your_diet_preference.
  ///
  /// In en, this message translates to:
  /// **'What\'s your diet preference?'**
  String get whats_your_diet_preference;

  /// No description provided for @how_much_time_do_you_have.
  ///
  /// In en, this message translates to:
  /// **'How much time do you have?'**
  String get how_much_time_do_you_have;

  /// No description provided for @spicyLevel.
  ///
  /// In en, this message translates to:
  /// **'Spicy level'**
  String get spicyLevel;

  /// No description provided for @tell_us_what_you_like.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you like'**
  String get tell_us_what_you_like;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @finish_and_generate.
  ///
  /// In en, this message translates to:
  /// **'Finish & Generate'**
  String get finish_and_generate;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @analytics_title.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics_title;

  /// No description provided for @analytics_range.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get analytics_range;

  /// No description provided for @analytics_no_yet.
  ///
  /// In en, this message translates to:
  /// **'No analytics yet'**
  String get analytics_no_yet;

  /// No description provided for @analytics_start_cooking.
  ///
  /// In en, this message translates to:
  /// **'Start cooking recipes to see insights'**
  String get analytics_start_cooking;

  /// No description provided for @analytics_your_cooking_insights.
  ///
  /// In en, this message translates to:
  /// **'Your Cooking Insights'**
  String get analytics_your_cooking_insights;

  /// No description provided for @analytics_based_on_cooking.
  ///
  /// In en, this message translates to:
  /// **'Based on recipes added to cooking'**
  String get analytics_based_on_cooking;

  /// No description provided for @analytics_favorite_to_cooking_ratio.
  ///
  /// In en, this message translates to:
  /// **'% of favorite recipes were added to cooking.'**
  String get analytics_favorite_to_cooking_ratio;

  /// No description provided for @recommended_recipes.
  ///
  /// In en, this message translates to:
  /// **'Recommended Recipes'**
  String get recommended_recipes;

  /// No description provided for @smart_recipe_based_on_your_sccan.
  ///
  /// In en, this message translates to:
  /// **'Smart recipes based on your scan'**
  String get smart_recipe_based_on_your_sccan;

  /// No description provided for @no_recipes_yet.
  ///
  /// In en, this message translates to:
  /// **'No recipes yet'**
  String get no_recipes_yet;

  /// No description provided for @preparing_your_recipes.
  ///
  /// In en, this message translates to:
  /// **'Preparing your recipes…'**
  String get preparing_your_recipes;

  /// No description provided for @suggested_recipes.
  ///
  /// In en, this message translates to:
  /// **'Suggested Recipes'**
  String get suggested_recipes;

  /// No description provided for @load_more_recipes.
  ///
  /// In en, this message translates to:
  /// **'Load more recipes'**
  String get load_more_recipes;

  /// No description provided for @loading_more_recipes.
  ///
  /// In en, this message translates to:
  /// **'Loading more recipes...'**
  String get loading_more_recipes;

  /// No description provided for @saved_recipes.
  ///
  /// In en, this message translates to:
  /// **'Saved Recipes'**
  String get saved_recipes;

  /// No description provided for @no_saved_recipes.
  ///
  /// In en, this message translates to:
  /// **'No saved recipes yet'**
  String get no_saved_recipes;

  /// No description provided for @save_recipes_to_find_them_here_later.
  ///
  /// In en, this message translates to:
  /// **'Save recipes to find them here later'**
  String get save_recipes_to_find_them_here_later;

  /// No description provided for @scan_your_ingredient.
  ///
  /// In en, this message translates to:
  /// **'Scan your ingredients.\nGet instant recipes powered by AI.'**
  String get scan_your_ingredient;

  /// No description provided for @this_week.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get this_week;

  /// No description provided for @top_cuisine.
  ///
  /// In en, this message translates to:
  /// **'Top Cuisine'**
  String get top_cuisine;

  /// No description provided for @avg_cook_time.
  ///
  /// In en, this message translates to:
  /// **'Avg Cook Time'**
  String get avg_cook_time;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @missing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get missing;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @name_a_z.
  ///
  /// In en, this message translates to:
  /// **'Name A-Z'**
  String get name_a_z;

  /// No description provided for @cook_time.
  ///
  /// In en, this message translates to:
  /// **'Cook Time'**
  String get cook_time;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get see_all;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @cal.
  ///
  /// In en, this message translates to:
  /// **'cal'**
  String get cal;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
