class GameClaim {
  String key;
  String value;

  GameClaim({this.key, this.value});

  factory GameClaim.fromMap(Map<String, dynamic> map) => GameClaim(
        key: map['key'],
        value: map['value'],
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'value': value,
      };
}
