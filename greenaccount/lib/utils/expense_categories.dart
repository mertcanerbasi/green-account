import 'package:flutter/material.dart';
import 'package:greenaccount/utils/colors.dart';

final List<String> expenseCategoriesTexts = ["Konut", "Fatura", "Kredi Kartı", "Birikim", "Diğer"];
final List<Icon> expenseCategoriesIcons = [
  Icon(
    Icons.apartment,
    color: primaryOrange,
  ),
  Icon(
    Icons.receipt_long,
    color: primaryRed,
  ),
  Icon(
    Icons.credit_card,
    color: primaryBlue,
  ),
  Icon(
    Icons.savings_outlined,
    color: primaryPink,
  ),
  Icon(
    Icons.currency_lira,
    color: primaryBrown,
  )
];

final List<Color> expenseCategoriesColors = [primaryOrange, primaryRed, primaryBlue, primaryPink, primaryBrown];
