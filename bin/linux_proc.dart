import 'dart:async';

import 'dart:io';
import 'dart:typed_data';

main() async {
  var procFile = File('/proc/stat');

  var randFile = await procFile.open();

  var buffer = Uint8List(200);

  print('Pid = $pid');

  int count = 0;
  var timer = Timer.periodic(Duration(milliseconds: 50), (t) async {
    // var lines = await procFile.readAsLines();
    await randFile.readInto(buffer);
    await randFile.setPosition(0);
    ++count;
    if ((count % 100) == 0) print('.');
  });

  await Future.delayed(Duration(seconds: 60));
  timer.cancel();

  // timer = Timer.periodic(Duration(milliseconds: 10), (t) async {
  //   var lines = await procFile.readAsLines();
  // });

  // await Future.delayed(Duration(seconds: 60));
  // timer.cancel();
}
