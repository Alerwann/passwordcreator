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
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Password Creator'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In fr, this message translates to:
  /// **'WELCOME'**
  String get welcome;

  /// No description provided for @choosePasswordType.
  ///
  /// In fr, this message translates to:
  /// **'Choisi ton type de mot de passe :'**
  String get choosePasswordType;

  /// No description provided for @defaultButton.
  ///
  /// In fr, this message translates to:
  /// **'Par défaut'**
  String get defaultButton;

  /// No description provided for @defaultDescription.
  ///
  /// In fr, this message translates to:
  /// **'(10 caractères dont au moins 1 majuscule, 1 minuscule, 1 chiffre, 1 spécial)'**
  String get defaultDescription;

  /// No description provided for @customButton.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisé'**
  String get customButton;

  /// No description provided for @configurationTitle.
  ///
  /// In fr, this message translates to:
  /// **'Configuration'**
  String get configurationTitle;

  /// No description provided for @minimumValuesLabel.
  ///
  /// In fr, this message translates to:
  /// **'Valeur minimum pour chaque type'**
  String get minimumValuesLabel;

  /// No description provided for @totalCharactersLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nombre total de caractères'**
  String get totalCharactersLabel;

  /// No description provided for @specialCharactersLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de caractères spéciaux'**
  String get specialCharactersLabel;

  /// No description provided for @uppercaseLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de majuscules'**
  String get uppercaseLabel;

  /// No description provided for @lowercaseLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de minuscules'**
  String get lowercaseLabel;

  /// No description provided for @digitsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de chiffres'**
  String get digitsLabel;

  /// No description provided for @generateButton.
  ///
  /// In fr, this message translates to:
  /// **'Générer'**
  String get generateButton;

  /// No description provided for @errorTotalTooLow.
  ///
  /// In fr, this message translates to:
  /// **'Le total ({total}) doit être ≥ à la somme des minimums ({sum})'**
  String errorTotalTooLow(int total, int sum);

  /// No description provided for @errorMinimumLength.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe doit contenir au moins 4 caractères'**
  String get errorMinimumLength;

  /// No description provided for @errorMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe mesure 30 caratère au maximum'**
  String get errorMaxLength;

  /// No description provided for @resultTitle.
  ///
  /// In fr, this message translates to:
  /// **'Création'**
  String get resultTitle;

  /// No description provided for @yourPassword.
  ///
  /// In fr, this message translates to:
  /// **'Ton mot de passe :'**
  String get yourPassword;

  /// No description provided for @copyButton.
  ///
  /// In fr, this message translates to:
  /// **'Copier'**
  String get copyButton;

  /// No description provided for @copiedButton.
  ///
  /// In fr, this message translates to:
  /// **'Copié !'**
  String get copiedButton;

  /// No description provided for @regenerateButton.
  ///
  /// In fr, this message translates to:
  /// **'Regénérer'**
  String get regenerateButton;

  /// No description provided for @passwordRegenerated.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mot de passe généré !'**
  String get passwordRegenerated;

  /// No description provided for @generating.
  ///
  /// In fr, this message translates to:
  /// **'GÉNÉRATION...'**
  String get generating;
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
    'that was used.',
  );
}
