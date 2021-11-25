class References {
  static const String appName = "accelerator";
  static const int regressionSize = 8;
  static const double samplingRate = 50;

  static Duration get period => Duration(milliseconds: (1 / samplingRate * 1000).round());
}
