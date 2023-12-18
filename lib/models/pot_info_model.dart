class PotInfo {
  num? temp;
  int? humi;
  int? soilHumi;
  int? isWatering;
  int? isLighting;

  PotInfo({
    this.temp,
    this.humi,
    this.soilHumi,
    this.isWatering,
    this.isLighting,
  });

  factory PotInfo.fromJson(Map<String, dynamic> json) {
    return PotInfo(
      temp: json['potList'][0]['sensorData']['temp'],
      humi: json['potList'][0]['sensorData']['humi'],
      soilHumi: json['potList'][0]['sensorData']['soilHumi'],
      isWatering: json['potList'][0]['stateData']['isWatering'],
      isLighting: json['potList'][0]['stateData']['isLighting'],
    );
  }
}
