class Lesson {
  final String id;
  final String title;
  final String image;

  Lesson({this.id, this.title, this.image});
}

List<Lesson> lessons = [
  Lesson(id: "1", title: 'Đếm các số trong phạm vi 10', image: 'mars.png'),
  Lesson(
      id: "2",
      title: 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
      image: 'earth.png'),
  Lesson(
      id: "3", title: 'Nhiều hơn - Ít hơn - Bằng nhau', image: 'mercury.png'),
  Lesson(id: "4", title: 'Phép cộng trong phạm vi 10', image: 'moon.png'),
  Lesson(id: "5", title: 'Phép trừ trong phạm vi 10', image: 'neptune.png'),
];
