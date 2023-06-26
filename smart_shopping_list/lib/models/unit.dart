enum Unit {
  GRAM("Gramm"),
  LITRE("Liter"),
  PART("Teile");

  const Unit(this.code);

  final String code;

  static Unit? findByCode(String code) {
    switch (code) {
      case "Gramm":
        return Unit.GRAM;
      case "Liter":
        return Unit.LITRE;
      case "Teile":
        return Unit.PART;
      default:
        return null;
    }
  }

  String getOutputName() {
    return code;
  }
}
