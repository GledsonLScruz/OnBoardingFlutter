import 'dart:convert';

import 'package:cashob/pages/model/Currency.dart';
import 'package:cashob/pages/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Currency>> currencies = fetchCurrencies();
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<List<Currency>>(
        future: currencies,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.all(2.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return CurrencyItem(currency: snapshot.data![i]);
                    //onDelete, onEdit);
                  },
                )
              : Text('${snapshot.error}');
        },
      ),
    ));
  }
}

Future<List<Currency>> fetchCurrencies() async {
  const apiHost = 'https://api.frankfurter.app';
  final currencies = await http.get(Uri.parse('$apiHost/currencies'));
  final values = await http.get(Uri.parse('$apiHost/latest?from=BRL'));

  if (currencies.statusCode == 200 && values.statusCode == 200) {
    List<Currency> listOfCurrencies = [];
    jsonDecode(currencies.body).forEach((key, value) {
      listOfCurrencies
          .add(Currency(name: value.toString(), code: key.toString()));
    });

    Map valuesmap = jsonDecode(values.body)["rates"];

    listOfCurrencies.forEach((currency) {
      currency.setValue(valuesmap[currency.getCode()] == null
          ? -1.0
          : convertDouble(valuesmap[currency.getCode()]));
    });

    return listOfCurrencies;
  } else {
    throw Exception('Failed to load album');
  }
}

double convertDouble(dynamic e) {
  dynamic result;
  if (e != null) {
    if (e is String) {
      result = double.parse(e);
    } else if (e is int) {
      result = e.toDouble();
    } else if (e is double) {
      result = e;
    }
  }
  return result;
}
