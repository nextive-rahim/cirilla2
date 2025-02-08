import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class AddressFieldHeading extends StatelessWidget {
  final Map<String, dynamic> field;

  const AddressFieldHeading({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String label = get(field, ['label'], '');
    return Text(label, style: theme.textTheme.headlineSmall);
  }
}
