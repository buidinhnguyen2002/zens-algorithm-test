import 'dart:io';

void miniMaxSum(List<int> arr) {
  arr.sort();
  int totalSum = arr.reduce((value, element) => value + element);
  int minSum = totalSum - arr.last;
  int maxSum = totalSum - arr.first;
  print('$minSum $maxSum');
}

List<int> convertInputToList(String input) {
  List<int> result =
      input.split(' ').map((String number) => int.parse(number)).toList();
  return result;
}

void main() {
  // List<int> arr = [1, 4, 3, 2, 5];
  // List<int> arr = [1, 3, 5, 7, 9];

  print("Enter five positive integers: ");
  String input = stdin.readLineSync()!;
  try {
    List<int> arr = convertInputToList(input);
    print("Input: \n$input");
    print("Output: ");
    miniMaxSum(arr);
  } catch (e) {
    print("Format input error. Please enter again!");
  }
}
