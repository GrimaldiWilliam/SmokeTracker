// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get name => 'Nom';

  @override
  String get n_a => 'N/A';

  @override
  String get save => 'Enregister';

  @override
  String get aboutScreenTitle => 'Quant à ExHale';

  @override
  String get aboutDescriptionTitle => 'ExHale - Stats pour arrêter de fumer';

  @override
  String get aboutDescriptionText =>
      'ExHale est une application libre conçue pour vous aider à suivre le temps écoulé depuis que vous avez fumé pour la dernière fois et à voir les progrès que vous avez réalisés. Elle calcule le nombre de cigarettes évitées et l\'argent que vous avez économisé en fonction de vos habitudes tabagiques.';

  @override
  String get aboutPrivacyTitle => 'Vie privée et code source ouvert';

  @override
  String get aboutPrivacyText =>
      'ExHale respecte votre vie privée. L\'application ne collecte pas vos données et toutes vos informations sont stockées localement sur votre appareil. Le code source est disponible pour être examiné, ce qui garantit une transparence totale.';

  @override
  String get aboutLinksTitle => 'Liens';

  @override
  String get aboutLinksViewSourceCode => 'Voir le code source';

  @override
  String get aboutLinksReportAnIssue => 'Signaler un problème';

  @override
  String get aboutCreditsTitle => 'Crédits';

  @override
  String get aboutCreditsText =>
      'L\'icône de l\'application est fournie par OpenMoji - un projet open-source d\'emoji. Merci à OpenMoji pour leur travail remarquable !';

  @override
  String get aboutCreditsOpenMoji => 'Visiter OpenMoji';

  @override
  String get aboutCreditsMyWebsite => 'Visiter mon site web';

  @override
  String get aboutCreditsLiberapay => 'Support me on Liberapay';

  @override
  String get configSnackBarValidNumber =>
      'Veuillez entrer des chiffres valides avant de sauvegarder.';

  @override
  String get configDialogEnableFriendsTitle => 'Activer les amis';

  @override
  String get configDialogEnableFriendsDataText =>
      'L\'activation des Amis nécessite une connexion internet, partager l\'UID aléatoire et les statistiques de votre appareil avec le serveur : exhale.retiolus.net.';

  @override
  String get configDialogEnableFriendsSourceCodeText =>
      'Le code source de l\'API est disponible à l\'adresse suivante :';

  @override
  String get configScreenTitle => 'Configuration';

  @override
  String get configOptionEnableFriendsText => 'Activer les amis';

  @override
  String get configOptionPacketsPerWeekText => 'Paquets par semaine';

  @override
  String get configOptionCigarettesPerPacketText => 'Cigarettes par paquet';

  @override
  String get configOptionCounterStartDateText => 'Date de début du compteur';

  @override
  String get configOptionCounterStartDateSelectText => 'Sélectionnez une date';

  @override
  String get configOptionPriceHistoryText => 'Historique des prix';

  @override
  String get configOptionPriceHistoryPriceText => 'Prix de vente';

  @override
  String get configButtonAddPriceText => 'Ajouter un prix';

  @override
  String get configOptionThemeTitle => 'Theme';

  @override
  String get configOptionThemeLight => 'Light';

  @override
  String get configOptionThemeDark => 'Dark';

  @override
  String get configOptionThemeSystem => 'System';

  @override
  String get friendsDialogUIDYourQRText => 'Votre code QR';

  @override
  String get friendsDialogUIDNotAvailable =>
      'Pas d\'UID d\'utilisateur disponible';

  @override
  String get friendsDialogUIDNoUserUID => 'Pas d\'UID d\'utilisateur';

  @override
  String get friendsDialogUIDCopiedToClipboard =>
      'Copié dans le presse-papiers !';

  @override
  String get friendsDialogUIDCopyUID => 'Copier l\'UID';

  @override
  String get friendsDialogAddFriendTitle => 'Ajouter un(e) ami(e)';

  @override
  String get friendsDialogAddFriendNameText => 'Nom';

  @override
  String get friendsDialogAddFriendUIDText => 'UID';

  @override
  String get friendsSnackBarSyncSuccessfull =>
      'Les données ont été synchronisées avec succès !';

  @override
  String get friendsSnackBarSyncFailed =>
      'Échec de la synchronisation des données.';

  @override
  String get friendsScreenTitle => 'Amis';

  @override
  String get friendsNoFriendsText =>
      'Pas encore d\'amis, ajoutez-en pour voir leurs progrès !';

  @override
  String friendsLastSmokedText(String lastSmoked) {
    return 'Dernière cigarette : $lastSmoked';
  }

  @override
  String friendsCigarettesAvoidedText(String cigAvoided) {
    return 'Cigarettes évitées : $cigAvoided';
  }

  @override
  String friendsMoneySavedText(String moneySaved) {
    return 'Argent économisé : \$$moneySaved';
  }

  @override
  String friendsLastAnnouncedText(String lastAnnounced) {
    return 'Dernière annonce : $lastAnnounced';
  }

  @override
  String get friendsButtonShowUID => 'Afficher mon UID';

  @override
  String get friendsButtonShowUIDEnterUIDText => 'Saisir manuellement l\'UID';

  @override
  String get friendsButtonAddFriend => 'Ajouter un(e) ami(e)';

  @override
  String get friendsDialogEditFriendsNameTitle => 'Modifier le nom de l\'ami';

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
  String get homeMenuAbout => 'À propos';

  @override
  String get homeSnackBarFriendsDisabled =>
      'L\'écran des amis est désactivé dans les paramètres.';

  @override
  String homeCigarettesAvoidedText(String cigarettesAvoided) {
    return 'Cigarettes évitées :$cigarettesAvoided';
  }

  @override
  String homeMoneySavedText(String moneySaved) {
    return 'Argent économisé : \$$moneySaved';
  }

  @override
  String get homeStartCounterText => 'Démarrer le compteur';

  @override
  String get homeRestartProgressText => 'Redémarrer la progression';

  @override
  String get navigationFriendsDisabled =>
      'Friends feature is disabled. Enable it in settings.';
}
