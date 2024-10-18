enum Flavor {
  REDE_SOCIAL,
  KIWI,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.REDE_SOCIAL:
        return 'App Rede Social';
      case Flavor.KIWI:
        return 'App Kiwi';
      default:
        return 'title';
    }
  }
  static String pathAsset(String pathOrigem) {
    if (appFlavor == Flavor.REDE_SOCIAL)
      return pathOrigem;
    else {
      var output =
          '${pathOrigem.split('/')[0]}/${F.appFlavor?.name.toLowerCase()}/${pathOrigem.split('/')[2]}';
      return output;
    }
  }
}
