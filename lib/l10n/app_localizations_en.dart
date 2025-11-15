// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Password Creator';

  @override
  String get welcome => 'WELCOME';

  @override
  String get choosePasswordType => 'Choose your password type:';

  @override
  String get defaultButton => 'Default';

  @override
  String get defaultDescription =>
      '(10 characters with at least 1 uppercase, 1 lowercase, 1 digit, 1 special)';

  @override
  String get customButton => 'Custom';

  @override
  String get configurationTitle => 'Configuration';

  @override
  String get minimumValuesLabel => 'Minimum value for each type';

  @override
  String get totalCharactersLabel => 'Total number of characters';

  @override
  String get specialCharactersLabel => 'Number of special characters';

  @override
  String get uppercaseLabel => 'Number of uppercase letters';

  @override
  String get lowercaseLabel => 'Number of lowercase letters';

  @override
  String get digitsLabel => 'Number of digits';

  @override
  String get generateButton => 'Generate';

  @override
  String errorTotalTooLow(int total, int sum) {
    return 'The total ($total) must be ≥ to the sum of minimums ($sum)';
  }

  @override
  String get errorMinimumLength =>
      'The password must contain at least 4 characters';

  @override
  String get errorMaxLength =>
      'The password must be a maximum of 30 characters long. ';

  @override
  String get resultTitle => 'Creation';

  @override
  String get yourPassword => 'Your password:';

  @override
  String get copyButton => 'Copy';

  @override
  String get copiedButton => 'Copied!';

  @override
  String get regenerateButton => 'Regenerate';

  @override
  String get passwordRegenerated => 'New password generated!';

  @override
  String get generating => 'GENERATING...';
}
