import 'package:alfabetizando/components/minhas_silabas.dart';
import 'package:flutter/material.dart';

class Silabas1 extends StatelessWidget {
  Silabas1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 120,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sílabas",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      size: 50,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Clique nas consoantes",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: MinhasSilabas(),
    );
  }
}
