const ENV env = ENV.development;

enum ENV { development, qa, uat }

extension ConfigExt on ENV {
  String get baseurl {
    switch (this) {
      case ENV.qa:
        return 'https://api.github.com/';
      case ENV.development:
        return 'https://api.github.com/';
      case ENV.uat:
        return 'https://api.github.com/';
    }
  }
}
