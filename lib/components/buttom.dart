import 'package:flutter/material.dart';

class Buttom extends StatelessWidget {
  final String texto;
  final void Function(BuildContext) submitForm;
  final Color? color;
  const Buttom({
    required this.texto,
    required this.submitForm,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              color == null ? Theme.of(context).primaryColor : color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.all(15),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: () => submitForm(context),
        child: Text(
          texto,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
