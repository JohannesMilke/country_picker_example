import 'package:meta/meta.dart';

class Country {
  final String name;
  final String nativeName;
  final String code;

  const Country({
    @required this.name,
    @required this.nativeName,
    @required this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name'],
        code: json['code'],
        nativeName: json['native'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          nativeName == other.nativeName &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ nativeName.hashCode ^ code.hashCode;
}
