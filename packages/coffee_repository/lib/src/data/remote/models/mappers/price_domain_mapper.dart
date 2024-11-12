import 'package:coffee_repository/coffee_repository.dart';

extension PriceDomainMapper on PriceResponse {
  PriceDomain toDomain() {
    return PriceDomain(
      value: value,
      currency: currency,
    );
  }
}
