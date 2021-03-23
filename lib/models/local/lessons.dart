class Lesson {
  final String title;
  final String image;

  Lesson({this.title, this.image});
}

List<Lesson> lessons = [
  Lesson(title: 'Đếm các số trong phạm vi 10', image: 'mars.png'),
  Lesson(
      title: 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
      image: 'earth.png'),
  Lesson(title: 'Nhiều hơn - Ít hơn - Bằng nhau', image: 'mercury.png'),
  Lesson(title: 'Phép cộng trong phạm vi 10', image: 'moon.png'),
  Lesson(title: 'Phép trừ trong phạm vi 10', image: 'neptune.png'),
];
