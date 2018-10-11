import 'package:test/test.dart';
import 'package:pipelion/json_loader.dart';

void main() {
  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

  test('loading asset data from static thing', () {
    loadAssets(["thing1", "thing2", "thing3"]);
  });
}
