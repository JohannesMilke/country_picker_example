import 'package:country_picker_example/model/country.dart';
import 'package:country_picker_example/widget/flag_widget.dart';
import 'package:flutter/material.dart';

class CountryListTileWidget extends StatelessWidget {
  final Country country;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<Country> onSelectedCountry;

  const CountryListTileWidget({
    Key key,
    @required this.country,
    @required this.isNative,
    @required this.isSelected,
    @required this.onSelectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
            fontSize: 18,
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedCountry(country),
      leading: FlagWidget(code: country.code),
      title: Text(
        isNative ? country.nativeName : country.name,
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
