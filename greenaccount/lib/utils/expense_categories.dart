import 'package:flutter/material.dart';
import 'package:greenaccount/utils/colors.dart';

final List<String> expenseCategoriesTexts = ["Konut", "Fatura", "Kredi Kartı", "Birikim", "Diğer"];
final List<Icon> expenseCategoriesIcons = [
  const Icon(
    Icons.apartment,
    color: primaryOrange,
  ),
  const Icon(
    Icons.receipt_long,
    color: primaryRed,
  ),
  const Icon(
    Icons.credit_card,
    color: primaryBlue,
  ),
  const Icon(
    Icons.savings_outlined,
    color: primaryPink,
  ),
  const Icon(
    Icons.currency_lira,
    color: primaryBrown,
  )
];

final List<Color> expenseCategoriesColors = [primaryOrange, primaryRed, primaryBlue, primaryPink, primaryBrown];
