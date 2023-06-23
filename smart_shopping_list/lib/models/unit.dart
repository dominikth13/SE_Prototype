enum Unit {
  GRAM("gram"),
  LITRE("litre"),
  PART("part");

  const Unit(this.code);

  final String code;

  static Unit? findByCode(String code) {
    switch (code) {
      case "gram":
        return Unit.GRAM;
      case "litre":
        return Unit.LITRE;
      case "part":
        return Unit.PART;
      default:
        return null;
    }
  }

  String getOutputName() {
    return "$code(s)";
  }
}
