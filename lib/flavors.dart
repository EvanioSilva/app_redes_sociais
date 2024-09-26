enum Flavor { APP_REDES_SOCIAIS, APP_CURSO }

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.APP_CURSO:
        return 'App Curso';
      default:
        return 'App Redes Sociais';
    }
  }

  static String pathAsset(String pathOrigem) {
    if (appFlavor == Flavor.APP_REDES_SOCIAIS)
      return pathOrigem;
    else {
      var output =
          '${pathOrigem.split('/')[0]}/${F.appFlavor?.name.toLowerCase()}/${pathOrigem.split('/')[2]}';
      return output;
    }
  }
}
