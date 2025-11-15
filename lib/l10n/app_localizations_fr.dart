// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Password Creator';

  @override
  String get welcome => 'WELCOME';

  @override
  String get choosePasswordType => 'Choisi ton type de mot de passe :';

  @override
  String get defaultButton => 'Par défaut';

  @override
  String get defaultDescription =>
      '(10 caractères dont au moins 1 majuscule, 1 minuscule, 1 chiffre, 1 spécial)';

  @override
  String get customButton => 'Personnalisé';

  @override
  String get configurationTitle => 'Configuration';

  @override
  String get minimumValuesLabel => 'Valeur minimum pour chaque type';

  @override
  String get totalCharactersLabel => 'Nombre total de caractères';

  @override
  String get specialCharactersLabel => 'Nombre de caractères spéciaux';

  @override
  String get uppercaseLabel => 'Nombre de majuscules';

  @override
  String get lowercaseLabel => 'Nombre de minuscules';

  @override
  String get digitsLabel => 'Nombre de chiffres';

  @override
  String get generateButton => 'Générer';

  @override
  String errorTotalTooLow(int total, int sum) {
    return 'Le total ($total) doit être ≥ à la somme des minimums ($sum)';
  }

  @override
  String get errorMinimumLength =>
      'Le mot de passe doit contenir au moins 4 caractères';

  @override
  String get errorMaxLength => 'Le mot de passe mesure 30 caratère au maximum';

  @override
  String get resultTitle => 'Création';

  @override
  String get yourPassword => 'Ton mot de passe :';

  @override
  String get copyButton => 'Copier';

  @override
  String get copiedButton => 'Copié !';

  @override
  String get regenerateButton => 'Regénérer';

  @override
  String get passwordRegenerated => 'Nouveau mot de passe généré !';

  @override
  String get generating => 'GÉNÉRATION...';
}
