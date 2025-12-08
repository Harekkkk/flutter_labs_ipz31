void main() {
  // Варіант 27
  // Функція: y = 9/x + x^2
  // Діапазон: (-3, 3) -> не включаючи -3 та 3
  // Крок: 0.25
  // Завдання: Сума значень

  const double valueFrom = -3.0;
  const double valueTo = 3.0;
  const double step = 0.25;
  
  print("Лабораторна робота №2 (Варіант 27)");
  print("Функція: y = 9 / x + x^2");
  print("Діапазон: ($valueFrom, $valueTo)");
  print("Крок: $step\n");

  double sum = 0.0;

  for (double x = valueFrom + step; x < valueTo; x += step) {
    
    x = double.parse(x.toStringAsFixed(2));

    if (x == 0.0) {
      print("x = $x \t y = не існує (ділення на нуль)");
      continue; 
    }

    final y = calc(x);
    
    print("x = $x \t y = ${y.toStringAsFixed(4)}");
    sum += y;
  }

  print("\nСума значень функції = ${sum.toStringAsFixed(4)}");
}

double calc(double x) {
  return (9 / x) + (x * x);
}
