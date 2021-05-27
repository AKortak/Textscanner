import 'package:flutter_driver/driver_extension.dart';
import 'package:hrw_textscanner/main.dart' as app;

void main() async {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  await app.main();
}
