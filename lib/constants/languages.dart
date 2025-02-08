import 'package:flutter/material.dart';

// Manual config locale
// ignore: constant_identifier_names
const LANGUAGES = {
  'en': Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
  'fr_FR': Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
};

// with plugin is [WPML, Polylang]
const multiLanguagePlugin = 'WPML';
