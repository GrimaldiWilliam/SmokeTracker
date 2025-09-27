import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @n_a.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get n_a;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @aboutScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'About ExHale'**
  String get aboutScreenTitle;

  /// No description provided for @aboutDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'ExHale - Quit Smoking Tracker'**
  String get aboutDescriptionTitle;

  /// No description provided for @aboutDescriptionText.
  ///
  /// In en, this message translates to:
  /// **'ExHale is an open-source app designed to help you track the time since you last smoked and see the progress you\'ve made. It calculates the number of cigarettes avoided and the money you\'ve saved based on your smoking habits.'**
  String get aboutDescriptionText;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and Open Source'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacyText.
  ///
  /// In en, this message translates to:
  /// **'ExHale respects your privacy. It does not track your data, and all your information is stored locally on your device. The source code is available for review, ensuring complete transparency.'**
  String get aboutPrivacyText;

  /// No description provided for @aboutLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get aboutLinksTitle;

  /// No description provided for @aboutLinksViewSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View Source Code'**
  String get aboutLinksViewSourceCode;

  /// No description provided for @aboutLinksReportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an Issue'**
  String get aboutLinksReportAnIssue;

  /// No description provided for @aboutCreditsTitle.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get aboutCreditsTitle;

  /// No description provided for @aboutCreditsText.
  ///
  /// In en, this message translates to:
  /// **'The app icon is provided by OpenMoji - an open-source emoji project. Thanks to OpenMoji for their amazing work!'**
  String get aboutCreditsText;

  /// No description provided for @aboutCreditsOpenMoji.
  ///
  /// In en, this message translates to:
  /// **'Visit OpenMoji'**
  String get aboutCreditsOpenMoji;

  /// No description provided for @aboutCreditsMyWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit My Website'**
  String get aboutCreditsMyWebsite;

  /// No description provided for @aboutCreditsLiberapay.
  ///
  /// In en, this message translates to:
  /// **'Support me on Liberapay'**
  String get aboutCreditsLiberapay;

  /// No description provided for @configSnackBarValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid numbers before saving.'**
  String get configSnackBarValidNumber;

  /// No description provided for @configDialogEnableFriendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Friends'**
  String get configDialogEnableFriendsTitle;

  /// No description provided for @configDialogEnableFriendsDataText.
  ///
  /// In en, this message translates to:
  /// **'Enabling the Friends requires an internet connection and will share your device\'s random UID and stats with the server: exhale.retiolus.net.'**
  String get configDialogEnableFriendsDataText;

  /// No description provided for @configDialogEnableFriendsSourceCodeText.
  ///
  /// In en, this message translates to:
  /// **'The source code of the API is available at:'**
  String get configDialogEnableFriendsSourceCodeText;

  /// No description provided for @configScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configScreenTitle;

  /// No description provided for @configOptionEnableFriendsText.
  ///
  /// In en, this message translates to:
  /// **'Enable Friends'**
  String get configOptionEnableFriendsText;

  /// No description provided for @configOptionPacketsPerWeekText.
  ///
  /// In en, this message translates to:
  /// **'Packets per week'**
  String get configOptionPacketsPerWeekText;

  /// No description provided for @configOptionCigarettesPerPacketText.
  ///
  /// In en, this message translates to:
  /// **'Cigarettes per packet'**
  String get configOptionCigarettesPerPacketText;

  /// No description provided for @configOptionCounterStartDateText.
  ///
  /// In en, this message translates to:
  /// **'Counter Start Date'**
  String get configOptionCounterStartDateText;

  /// No description provided for @configOptionCounterStartDateSelectText.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get configOptionCounterStartDateSelectText;

  /// No description provided for @configOptionPriceHistoryText.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get configOptionPriceHistoryText;

  /// No description provided for @configOptionPriceHistoryPriceText.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get configOptionPriceHistoryPriceText;

  /// No description provided for @configButtonAddPriceText.
  ///
  /// In en, this message translates to:
  /// **'Add Price'**
  String get configButtonAddPriceText;

  /// No description provided for @configOptionThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get configOptionThemeTitle;

  /// No description provided for @configOptionThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get configOptionThemeLight;

  /// No description provided for @configOptionThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get configOptionThemeDark;

  /// No description provided for @configOptionThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get configOptionThemeSystem;

  /// No description provided for @friendsDialogUIDYourQRText.
  ///
  /// In en, this message translates to:
  /// **'Your QR Code'**
  String get friendsDialogUIDYourQRText;

  /// No description provided for @friendsDialogUIDNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'No User UID available'**
  String get friendsDialogUIDNotAvailable;

  /// No description provided for @friendsDialogUIDNoUserUID.
  ///
  /// In en, this message translates to:
  /// **'No User UID'**
  String get friendsDialogUIDNoUserUID;

  /// No description provided for @friendsDialogUIDCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get friendsDialogUIDCopiedToClipboard;

  /// No description provided for @friendsDialogUIDCopyUID.
  ///
  /// In en, this message translates to:
  /// **'Copy UID'**
  String get friendsDialogUIDCopyUID;

  /// No description provided for @friendsDialogAddFriendTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Friend'**
  String get friendsDialogAddFriendTitle;

  /// No description provided for @friendsDialogAddFriendNameText.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get friendsDialogAddFriendNameText;

  /// No description provided for @friendsDialogAddFriendUIDText.
  ///
  /// In en, this message translates to:
  /// **'UID'**
  String get friendsDialogAddFriendUIDText;

  /// No description provided for @friendsSnackBarSyncSuccessfull.
  ///
  /// In en, this message translates to:
  /// **'Data synced successfully!'**
  String get friendsSnackBarSyncSuccessfull;

  /// No description provided for @friendsSnackBarSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to sync data.'**
  String get friendsSnackBarSyncFailed;

  /// No description provided for @friendsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friendsScreenTitle;

  /// No description provided for @friendsNoFriendsText.
  ///
  /// In en, this message translates to:
  /// **'No friends yet, Add some to see their progress!'**
  String get friendsNoFriendsText;

  /// No description provided for @friendsLastSmokedText.
  ///
  /// In en, this message translates to:
  /// **'Last Smoked: {lastSmoked}'**
  String friendsLastSmokedText(String lastSmoked);

  /// No description provided for @friendsCigarettesAvoidedText.
  ///
  /// In en, this message translates to:
  /// **'Cigarettes avoided: {cigAvoided}'**
  String friendsCigarettesAvoidedText(String cigAvoided);

  /// No description provided for @friendsMoneySavedText.
  ///
  /// In en, this message translates to:
  /// **'Money Saved: \${moneySaved}'**
  String friendsMoneySavedText(String moneySaved);

  /// No description provided for @friendsLastAnnouncedText.
  ///
  /// In en, this message translates to:
  /// **'Last Announced: {lastAnnounced}'**
  String friendsLastAnnouncedText(String lastAnnounced);

  /// No description provided for @friendsButtonShowUID.
  ///
  /// In en, this message translates to:
  /// **'Show my UID'**
  String get friendsButtonShowUID;

  /// No description provided for @friendsButtonShowUIDEnterUIDText.
  ///
  /// In en, this message translates to:
  /// **'Enter UID Manually'**
  String get friendsButtonShowUIDEnterUIDText;

  /// No description provided for @friendsButtonAddFriend.
  ///
  /// In en, this message translates to:
  /// **'Add Friend'**
  String get friendsButtonAddFriend;

  /// No description provided for @friendsDialogEditFriendsNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Friend\'s Name'**
  String get friendsDialogEditFriendsNameTitle;

  /// No description provided for @health2DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'2 days after the last cigarette'**
  String get health2DaysTitle;

  /// No description provided for @health2DaysText.
  ///
  /// In en, this message translates to:
  /// **'Carbon monoxide is removed from the blood, improving oxygen circulation.'**
  String get health2DaysText;

  /// No description provided for @health3DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'3 days after quitting smoking'**
  String get health3DaysTitle;

  /// No description provided for @health3DaysText.
  ///
  /// In en, this message translates to:
  /// **'Breathing improves and shortness of breath becomes less frequent.'**
  String get health3DaysText;

  /// No description provided for @health7DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'7 days after quitting smoking'**
  String get health7DaysTitle;

  /// No description provided for @health7DaysText.
  ///
  /// In en, this message translates to:
  /// **'Taste and smell gradually return.'**
  String get health7DaysText;

  /// No description provided for @health2WeeksTitle.
  ///
  /// In en, this message translates to:
  /// **'2 weeks after quitting smoking'**
  String get health2WeeksTitle;

  /// No description provided for @health2WeeksText.
  ///
  /// In en, this message translates to:
  /// **'Sleep improves.'**
  String get health2WeeksText;

  /// No description provided for @health1MonthTitle.
  ///
  /// In en, this message translates to:
  /// **'1 month after quitting smoking'**
  String get health1MonthTitle;

  /// No description provided for @health1MonthText.
  ///
  /// In en, this message translates to:
  /// **'Voice becomes clearer.'**
  String get health1MonthText;

  /// No description provided for @health2MonthsTitle.
  ///
  /// In en, this message translates to:
  /// **'2.5 months without smoking'**
  String get health2MonthsTitle;

  /// No description provided for @health2MonthsText.
  ///
  /// In en, this message translates to:
  /// **'Facial complexion brightens. Skin tone improves.'**
  String get health2MonthsText;

  /// No description provided for @health3MonthsTitle.
  ///
  /// In en, this message translates to:
  /// **'3 months after quitting smoking'**
  String get health3MonthsTitle;

  /// No description provided for @health3MonthsText.
  ///
  /// In en, this message translates to:
  /// **'Coughing becomes less frequent and less severe.'**
  String get health3MonthsText;

  /// No description provided for @health1YearTitle.
  ///
  /// In en, this message translates to:
  /// **'1 year after the last cigarette'**
  String get health1YearTitle;

  /// No description provided for @health1YearText.
  ///
  /// In en, this message translates to:
  /// **'Heart attack risk is reduced by half, and stroke risk matches that of a non-smoker.'**
  String get health1YearText;

  /// No description provided for @health5YearsTitle.
  ///
  /// In en, this message translates to:
  /// **'5 years after the last cigarette'**
  String get health5YearsTitle;

  /// No description provided for @health5YearsText.
  ///
  /// In en, this message translates to:
  /// **'Lung cancer risk is reduced by nearly half.'**
  String get health5YearsText;

  /// No description provided for @health15YearsTitle.
  ///
  /// In en, this message translates to:
  /// **'10-15 years after the last cigarette'**
  String get health15YearsTitle;

  /// No description provided for @health15YearsText.
  ///
  /// In en, this message translates to:
  /// **'Life expectancy equals that of someone who has never smoked.'**
  String get health15YearsText;

  /// No description provided for @homeMenuConfig.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get homeMenuConfig;

  /// No description provided for @homeMenuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get homeMenuAbout;

  /// No description provided for @homeSnackBarFriendsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Friends screen is disabled in settings.'**
  String get homeSnackBarFriendsDisabled;

  /// No description provided for @homeCigarettesAvoidedText.
  ///
  /// In en, this message translates to:
  /// **'Cigarettes avoided: {cigarettesAvoided}'**
  String homeCigarettesAvoidedText(String cigarettesAvoided);

  /// No description provided for @homeMoneySavedText.
  ///
  /// In en, this message translates to:
  /// **'Money saved: \${moneySaved}'**
  String homeMoneySavedText(String moneySaved);

  /// No description provided for @homeStartCounterText.
  ///
  /// In en, this message translates to:
  /// **'Start Counter'**
  String get homeStartCounterText;

  /// No description provided for @homeRestartProgressText.
  ///
  /// In en, this message translates to:
  /// **'Restart Progress'**
  String get homeRestartProgressText;

  /// No description provided for @navigationFriendsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Friends feature is disabled. Enable it in settings.'**
  String get navigationFriendsDisabled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
