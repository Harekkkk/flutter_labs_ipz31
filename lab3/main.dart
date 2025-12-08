import 'calc.dart';

void main() {
  print("Лабораторна робота №3 (Варіант 27)");
  print("Функція: y = x^3 - 15");
  print("Діапазон: [-5, 5]");
  print("Крок: 0.5\n");

  // Створення об'єкту класу Calc з кроком 0.5
  final processor = Calc(0.5);
  
  // Запуск розрахунків
  processor.runCalc();
  
  // Вивід додаткового завдання (мін/макс)
  print("\nMin: ${processor.minVal?.toStringAsFixed(4)}");
  print("Max: ${processor.maxVal?.toStringAsFixed(4)}");
}
