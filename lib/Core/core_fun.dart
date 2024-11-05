class CoreFun {
  static double toDouble(value) {
    if (value is int) {
      return double.parse(value.toString());
    }
    return value;
  }
}
