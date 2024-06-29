
class PulseData {
  final int value;

  PulseData(this.value,);

  factory PulseData.fromMap(Map<String, int> map) =>
      PulseData(map['value'] !, );
}

class TempData {
  final int value;

  TempData(this.value,);

  factory TempData.fromMap(Map<String, int> map) =>
      TempData(map['value'] !, );
}
class OxygenData {
  final int value;

  OxygenData(this.value,);

  factory OxygenData.fromMap(Map<String, int> map) =>
      OxygenData(map['value']! , );
}

