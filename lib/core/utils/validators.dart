import 'package:reactive_forms/reactive_forms.dart';

class AppValidators {
  static final email = Validators.compose([
    Validators.required,
    Validators.email,
  ]);

  static final password = Validators.compose([
    Validators.required,
    Validators.minLength(6),
  ]);
}
