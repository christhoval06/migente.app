import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mi_gente/models/person.dart';

class CodePage extends StatelessWidget {
  final String route;
  final Person? person;

  final List<String> codes = [
    "6757",
    "4186",
    "3313",
    "1510",
    "6678",
    "2473",
    "4149",
    "4598",
    "3796",
    "6827",
    "3773",
    "7983",
    "6123",
    "6604",
    "1201",
    "0678",
    "5606",
    "3499",
    "0432",
    "7669"
  ];

  CodePage({super.key, required this.route, this.person});

  void validateCode(BuildContext context, String code) {
    if (codes.contains(code)) {
      // Navigator.pushNamed(context, route);
      Navigator.pushReplacementNamed(context, route,
          arguments: {'person': person});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El código proporcionado no es correcto.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Mi Gente"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hola!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 16),
                const Icon(Icons.account_circle,
                    color: Colors.indigoAccent, size: 96),
                const SizedBox(height: 16),
                const Text("Bienvenido a Mi Gente",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: Theme.of(context).colorScheme.primary,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    validateCode(context, verificationCode);
                  }, // end onSubmit
                ),
                const SizedBox(height: 16),
                const Text("Coloca el código que te han proporcionado")
              ],
            ),
          ),
        ));
  }
}
