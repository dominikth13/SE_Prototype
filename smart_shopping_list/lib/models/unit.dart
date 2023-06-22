enum Unit {
  GRAMS("grams"),
  LITRE("litre"),
  PARTS("parts");

  const Unit(this.code);

  final String code;

  static Unit? findByCode(String code) {
    switch (code) {
      case "grams":
        return Unit.GRAMS;
      case "litre":
        return Unit.LITRE;
      case "parts":
        return Unit.PARTS;
      default:
        return null;
    }
  }
}
