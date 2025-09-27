// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get name => 'Name';

  @override
  String get n_a => 'N/A';

  @override
  String get save => 'Save';

  @override
  String get aboutScreenTitle => 'About ExHale';

  @override
  String get aboutDescriptionTitle => 'ExHale - Quit Smoking Tracker';

  @override
  String get aboutDescriptionText =>
      'ExHale is an open-source app designed to help you track the time since you last smoked and see the progress you\'ve made. It calculates the number of cigarettes avoided and the money you\'ve saved based on your smoking habits.';

  @override
  String get aboutPrivacyTitle => 'Privacy and Open Source';

  @override
  String get aboutPrivacyText =>
      'ExHale respects your privacy. It does not track your data, and all your information is stored locally on your device. The source code is available for review, ensuring complete transparency.';

  @override
  String get aboutLinksTitle => 'Links';

  @override
  String get aboutLinksViewSourceCode => 'View Source Code';

  @override
  String get aboutLinksReportAnIssue => 'Report an Issue';

  @override
  String get aboutCreditsTitle => 'Credits';

  @override
  String get aboutCreditsText =>
      'The app icon is provided by OpenMoji - an open-source emoji project. Thanks to OpenMoji for their amazing work!';

  @override
  String get aboutCreditsOpenMoji => 'Visit OpenMoji';

  @override
  String get aboutCreditsMyWebsite => 'Visit My Website';

  @override
  String get aboutCreditsLiberapay => 'Support me on Liberapay';

  @override
  String get configSnackBarValidNumber =>
      'Please enter valid numbers before saving.';

  @override
  String get configDialogEnableFriendsTitle => 'Enable Friends';

  @override
  String get configDialogEnableFriendsDataText =>
      'Enabling the Friends requires an internet connection and will share your device\'s random UID and stats with the server: exhale.retiolus.net.';

  @override
  String get configDialogEnableFriendsSourceCodeText =>
      'The source code of the API is available at:';

  @override
  String get configScreenTitle => 'Configuration';

  @override
  String get configOptionEnableFriendsText => 'Enable Friends';

  @override
  String get configOptionPacketsPerWeekText => 'Packets per week';

  @override
  String get configOptionCigarettesPerPacketText => 'Cigarettes per packet';

  @override
  String get configOptionCounterStartDateText => 'Counter Start Date';

  @override
  String get configOptionCounterStartDateSelectText => 'Select a date';

  @override
  String get configOptionPriceHistoryText => 'Price History';

  @override
  String get configOptionPriceHistoryPriceText => 'Price';

  @override
  String get configButtonAddPriceText => 'Add Price';

  @override
  String get configOptionThemeTitle => 'Theme';

  @override
  String get configOptionThemeLight => 'Light';

  @override
  String get configOptionThemeDark => 'Dark';

  @override
  String get configOptionThemeSystem => 'System';

  @override
  String get friendsDialogUIDYourQRText => 'Your QR Code';

  @override
  String get friendsDialogUIDNotAvailable => 'No User UID available';

  @override
  String get friendsDialogUIDNoUserUID => 'No User UID';

  @override
  String get friendsDialogUIDCopiedToClipboard => 'Copied to clipboard!';

  @override
  String get friendsDialogUIDCopyUID => 'Copy UID';

  @override
  String get friendsDialogAddFriendTitle => 'Add Friend';

  @override
  String get friendsDialogAddFriendNameText => 'Name';

  @override
  String get friendsDialogAddFriendUIDText => 'UID';

  @override
  String get friendsSnackBarSyncSuccessfull => 'Data synced successfully!';

  @override
  String get friendsSnackBarSyncFailed => 'Failed to sync data.';

  @override
  String get friendsScreenTitle => 'Friends';

  @override
  String get friendsNoFriendsText =>
      'No friends yet, Add some to see their progress!';

  @override
  String friendsLastSmokedText(String lastSmoked) {
    return 'Last Smoked: $lastSmoked';
  }

  @override
  String friendsCigarettesAvoidedText(String cigAvoided) {
    return 'Cigarettes avoided: $cigAvoided';
  }

  @override
  String friendsMoneySavedText(String moneySaved) {
    return 'Money Saved: \$$moneySaved';
  }

  @override
  String friendsLastAnnouncedText(String lastAnnounced) {
    return 'Last Announced: $lastAnnounced';
  }

  @override
  String get friendsButtonShowUID => 'Show my UID';

  @override
  String get friendsButtonShowUIDEnterUIDText => 'Enter UID Manually';

  @override
  String get friendsButtonAddFriend => 'Add Friend';

  @override
  String get friendsDialogEditFriendsNameTitle => 'Edit Friend\'s Name';

  @override
  String get health2DaysTitle => '2 days after the last cigarette';

  @override
  String get health2DaysText =>
      'Carbon monoxide is removed from the blood, improving oxygen circulation.';

  @override
  String get health3DaysTitle => '3 days after quitting smoking';

  @override
  String get health3DaysText =>
      'Breathing improves and shortness of breath becomes less frequent.';

  @override
  String get health7DaysTitle => '7 days after quitting smoking';

  @override
  String get health7DaysText => 'Taste and smell gradually return.';

  @override
  String get health2WeeksTitle => '2 weeks after quitting smoking';

  @override
  String get health2WeeksText => 'Sleep improves.';

  @override
  String get health1MonthTitle => '1 month after quitting smoking';

  @override
  String get health1MonthText => 'Voice becomes clearer.';

  @override
  String get health2MonthsTitle => '2.5 months without smoking';

  @override
  String get health2MonthsText =>
      'Facial complexion brightens. Skin tone improves.';

  @override
  String get health3MonthsTitle => '3 months after quitting smoking';

  @override
  String get health3MonthsText =>
      'Coughing becomes less frequent and less severe.';

  @override
  String get health1YearTitle => '1 year after the last cigarette';

  @override
  String get health1YearText =>
      'Heart attack risk is reduced by half, and stroke risk matches that of a non-smoker.';

  @override
  String get health5YearsTitle => '5 years after the last cigarette';

  @override
  String get health5YearsText => 'Lung cancer risk is reduced by nearly half.';

  @override
  String get health15YearsTitle => '10-15 years after the last cigarette';

  @override
  String get health15YearsText =>
      'Life expectancy equals that of someone who has never smoked.';

  @override
  String get homeMenuConfig => 'Configuration';

  @override
  String get homeMenuAbout => 'About';

  @override
  String get homeSnackBarFriendsDisabled =>
      'Friends screen is disabled in settings.';

  @override
  String homeCigarettesAvoidedText(String cigarettesAvoided) {
    return 'Cigarettes avoided: $cigarettesAvoided';
  }

  @override
  String homeMoneySavedText(String moneySaved) {
    return 'Money saved: \$$moneySaved';
  }

  @override
  String get homeStartCounterText => 'Start Counter';

  @override
  String get homeRestartProgressText => 'Restart Progress';

  @override
  String get navigationFriendsDisabled =>
      'Friends feature is disabled. Enable it in settings.';
}
