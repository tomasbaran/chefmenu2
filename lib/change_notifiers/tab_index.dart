import 'package:flutter/foundation.dart';

class TabIndex extends ChangeNotifier {
  int position = 0;

  updatePosition(int newPosition) {
    position = newPosition;
    print('newPosition: $newPosition');
    notifyListeners();
  }
}
