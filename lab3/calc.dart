class Calc {
  double step;
  double _from = -5.0;
  double _to = 5.0;
  
  double? minVal;
  double? maxVal;

  Calc(this.step);

  void setRange(double from, double to) {
    _from = from;
    _to = to;
  }

  void runCalc() {
    double x = _from;
    
    while (x <= _to + 0.0001) {
      x = double.parse(x.toStringAsFixed(2));

      final y = _calc(x);
      print("x = $x \t y = ${y.toStringAsFixed(4)}");

      if (minVal == null || y < minVal!) {
        minVal = y;
      }
      if (maxVal == null || y > maxVal!) {
        maxVal = y;
      }

      x += step;
    }
  }

  double _calc(double x) {
    return (x * x * x) - 15;
  }
}
