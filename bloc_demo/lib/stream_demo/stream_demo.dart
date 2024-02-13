// async* 是一个异步生成器，通过yield返回一个Stream
Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}

Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  // 等待流中的每一个值，然后求和。
  await for (int value in stream) {
    sum += value;
  }
  return sum;
}

void main(List<String> args) async {
  var s = countStream(100);
  final result = await sumStream(s);
  print('$result');
}
