import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end test", () {});

  // Happy
  group("Happy Path", () async {
    test("Empty List", () => null);
  });
  // Sad
  group("Sad Path", () async {
    test("Empty List", () => null);
  });
}
