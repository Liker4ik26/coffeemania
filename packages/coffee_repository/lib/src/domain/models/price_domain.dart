import 'package:equatable/equatable.dart';

class PriceDomain extends Equatable {
  const PriceDomain({
    required this.value,
    required this.currency,
  });

  factory PriceDomain.fromString(String price) {
    final parts = price.split('+');
    return PriceDomain(value: parts[0], currency: parts[1]);
  }

  final String value;
  final String currency;

  @override
  List<Object?> get props => [
        value,
        currency,
      ];
}
