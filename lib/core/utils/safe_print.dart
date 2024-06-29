
import 'package:flutter/foundation.dart';

void safePrint(Object? message){
  if (kDebugMode) {
    print('==================> - - - - - - Safe safePrint - - - - - -  <==================');
    print(message);
    print('==================> - - - - - - Safe safePrint - - - - - -  <==================');
  }


}