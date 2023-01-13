import 'package:cashob/app/model/Currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/colors.dart';

class DetailPage extends StatefulWidget {
  Currency currency1;
  Currency currency2;
  DetailPage({super.key, required this.currency1, required this.currency2});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Currency Converter',
                style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Divider(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withAlpha(15),
                      offset: const Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(children: [
                  _converterCurrency(currency: widget.currency1),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ]),
              ),
              const Padding(
                padding: const EdgeInsets.all(25.0),
                child: Divider(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withAlpha(15),
                      offset: const Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(children: [
                  _converterCurrency(currency: widget.currency2),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _converterCurrency extends StatelessWidget {
  final Currency currency;
  const _converterCurrency({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 70,
              width: 70,
              child: SvgPicture.asset('assets/flags/${currency.code}.svg')),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${currency.name}',
                style: const TextStyle(
                    color: CustomColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '${currency.code}',
                style: const TextStyle(
                    color: CustomColors.lightblack,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ],
    );
  }
}
