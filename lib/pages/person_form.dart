import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/domain/people_controller.dart';
import 'package:mi_gente/models/person.dart';
import 'package:mi_gente/ui/locator.dart';
import 'package:mi_gente/utils/logger.dart';

class PersonForm extends StatelessWidget {
  final bool isNew;
  final Person? person;

  PersonForm({super.key, required this.isNew, this.person});

  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> onOpenQRCodeScan(BuildContext context) async {
    if (!isNew) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No puedes hacer esto!'),
      ));
      return;
    }

    final result = await Navigator.pushNamed(context, RoutePaths.qrCode);

    Map<String, dynamic>? values = Person.ndi2Map(result as String?);
    if (values != null) {
      _formKey.currentState?.patchValue(values);
    }
  }

  Future<void> save(BuildContext context) async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Datos incorrectos.'),
      ));
      return;
    }

    Map<String, dynamic> data =
        Map<String, dynamic>.from(_formKey.currentState!.value);
    data['birthdate'] = (data['birthdate'] as DateTime).toIso8601String();

    logger.d(data);

    Person newPerson = Person.fromJson(data);
    if (person != null) {
      newPerson.id = person?.id;
    }

    try {
      Person saved = await locator
          .get<PeopleDomainController>()
          .savePerson(newPerson, isNew: isNew);

      if (isNew) {
        _formKey.currentState?.reset();
      } else {
        _formKey.currentState?.patchValue(saved.toMap());
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Datos guardados correctamente.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Upps!!! ha ocurrido un error.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> values;
    if (person != null) {
      values = person!.toMap();
    } else {
      values = {
        "is_voted": false,
        'birthdate': DateTime.now().subtract(const Duration(days: 365 * 19))
      };
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(isNew ? 'Registro' : 'Actualización'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  save(context);
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                },
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: values,
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Datos Generales',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'names',
                          textCapitalization: TextCapitalization.words,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Este valor es requerido.'),
                            FormBuilderValidators.maxLength(40,
                                errorText:
                                    'El valor debe tener un largo no mayor a 40 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Nombres',
                            prefixIcon:
                                Icon(Icons.person, color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'last_names',
                          textCapitalization: TextCapitalization.words,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Este valor es requerido.'),
                            FormBuilderValidators.maxLength(40,
                                errorText:
                                    'El valor debe tener un largo no mayor a 40 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Apellidos',
                            prefixIcon:
                                Icon(Icons.person, color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'ndi',
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Este valor es requerido.'),
                            FormBuilderValidators.maxLength(15,
                                errorText:
                                    'El valor debe tener un largo no mayor a 15 carácteres.'),
                          ]),
                          decoration: InputDecoration(
                              labelText: 'Cédula',
                              prefixIcon: const Icon(Icons.credit_card,
                                  color: Colors.deepOrange),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    onOpenQRCodeScan(context);
                                  },
                                  icon: const Icon(Icons.qr_code_2))),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderDateTimePicker(
                          name: 'birthdate',
                          keyboardType: TextInputType.number,
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime.now()
                              .subtract(const Duration(days: 365 * 18)),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          // initialValue: DateTime.now(),
                          format: DateFormat('yyyy-MM-dd'),
                          inputType: InputType.date,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Este valor es requerido.')
                          ]),
                          decoration: InputDecoration(
                            labelText: 'Fecha de nacimiento',
                            prefixIcon: const Icon(Icons.cake_outlined,
                                color: Colors.deepOrange),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState!.fields['birthdate']
                                    ?.didChange(null);
                              },
                            ),
                          ),
                          initialTime: const TimeOfDay(hour: 8, minute: 0),
                          // locale: const Locale.fromSubtags(languageCode: 'fr'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Residencia y contacto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: "contact",
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(20,
                                errorText:
                                    'El valor debe tener un largo no mayor a 20 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon:
                                Icon(Icons.phone, color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: "address",
                          maxLines: 2,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(200,
                                errorText:
                                    'El valor debe tener un largo no mayor a 200 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Dirección',
                            prefixIcon:
                                Icon(Icons.home, color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Votación',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: "voting_place",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(200,
                                errorText:
                                    'El valor debe tener un largo no mayor a 200 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Centro',
                            prefixIcon:
                                Icon(Icons.school, color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: "voting_board",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(10,
                                errorText:
                                    'El valor debe tener un largo no mayor a 10 carácteres.'),
                          ]),
                          decoration: const InputDecoration(
                            labelText: 'Mesa',
                            prefixIcon: Icon(Icons.table_restaurant,
                                color: Colors.deepOrange),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'is_voted',
                          title: const Text('Ya ha votado!'),
                          activeColor: Colors.indigo,
                          side: const BorderSide(color: Colors.deepOrange),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () {
                    save(context);
                  },
                  icon: const Icon(Icons.save, color: Colors.white70),
                  label: Text(
                    isNew ? 'Guardar' : 'Actualizar',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.green,
                      elevation: 4.0,
                      animationDuration: const Duration(milliseconds: 1000),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }
}
