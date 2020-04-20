import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stayhome/service/data_provider.dart';
import 'package:stayhome/util/models.dart';

class App extends InheritedWidget {
  final SharedPreferences preferences;
  final DataProvider provider;
  final List<Statistic> statistics;

  App({this.statistics, this.provider, this.preferences, Widget child})
      : super(child: child);

  Statistic get currentCountry {
    final country = preferences.getString('currentCountry');
    if (country == null) return statistics.first;
    return statistics.singleWhere((stats) => stats.country == country);
  }

  set currentCountry(Statistic value) {
    preferences.setString('currentCountry', value.country);
  }

  final Map<String, String> symptoms = allSymptoms.first;
  static App of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<App>();
  }

  refreshStats(List<Statistic> value) {
    statistics
      ..clear()
      ..addAll(value);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

const allSymptoms = [
  {
    "picture": "symptom3",
    "title":  'Les symptômes les plus communs sont: ‎',
    "description":
        "Un des symptômes les plus courants de la maladie Covid-19 est la fièvre, comme pour la grippe. C'est pour cette raison que les deux maladies peuvent se confondre au début. Le niveau de fièvre est variable d'un individu à un autre, mais généralement le coronavirus provoque une fièvre de plus de 38°. Si votre seul symptôme est de la fièvre, n'appelez pas le 15. En cas de doutes, restez chez vous et appelez votre médecin. Etre fiévreux ne signifie pas avoir contracté le coronavirus. Si vous voulez lutter contre la fièvre ou la douleur, préférez le paracétamol aux anti-inflammatoires et à l'ibuprofène, soupçonnés d'aggraver les symptômes en cas de coronavirus. Si vous avez été en contact étroit avec une personne malade, prenez votre température deux fois par jour, et surtout appliquez bien les gestes barrières (lavage des mains régulier au savon et à l'eau, distance d'un mètre…). "
  },
  {
    "picture": "symptom2",
    "title": "Le coronavirus provoque-t-il une toux sèche ou grasse ?",
    "description":
        "Les patients Covid+ présentent une toux sèche. Aurore Jégu-Pétrot, infirmière, a rapporté sur BFMTV que cette toux, si elle devient ingérable, doit alerte : \"Quand tu vois que tu tousses à t'en étouffer tu te dis que tu vas avoir besoin d'aide respiratoire\"... Pourtant, dans la majorité des cas, cette toux s'éteint d'elle-même. L'OMS conseille d'appeler votre médecin traitant si vous avez une toux sèche."
  },
  {
    "picture": "symptom3",
    "title": "Y a-t-il des symptômes de courbatures ?",
    "description":
        "Comme pour la grippe, un symptôme très fréquent de la maladie Covid-19 est le fait d'avoir des douleurs musculaires. Si vous avez la sensation de courbatures partout, c'est peut être un signe que vous avez contracté le virus, ou tout simplement que vous avez la grippe saisonnière. Si vous êtes dans ce cas, il est recommandé de rester au chaud chez vous, de prendre votre température deux fois par jour et encore une fois d'appliquer les gestes barrières afin de ne pas contaminer les personnes de votre entourage. Appelez votre médecin, mais ce n'est pas la peine de faire le 15, sauf si vous êtes une personne à risque ou si vous avez en complément des symptômes aggravants comme des difficultés respiratoires."
  },
  {
    "picture": "symptom4",
    "title": "Qu'est-ce que l'anosmie, symptôme particulier du coronavirus ?",
    "description":
        "Les ORL ont alerté à la mi-mars les autorités de l'apparition d'un nouveau symptôme : l'anosmie (perte d'odorat). \"Ça semblait bizarre\", a confié à l'AFP le Dr Alain Corré, ORL à l'Hôpital-Fondation Rothschild à Paris. Avec le Dr Dominique Salmon de l'Hôtel Dieu, ils ont testé une soixantaine de patients anosmiques : 90% étaient positifs. Ces pertes d'odorat sembleraient être un symptôme pathognomonique, id est un signe clinique qui, à lui seul, permet d'établir le diagnostic. Ce symptôme est la seule présentation spécifique du nouveau coronavirus. Le Dr Corré a théorisé : \"Le virus SARS Cov-2 est attiré par les nerfs: quand il pénètre dans le nez, au lieu de s'attaquer à la muqueuse comme le font les rhinovirus habituels, il attaque le nerf olfactif et bloque les molécules d'odeur. \" Le médecin a assuré : \"Dans le contexte actuel, si vous avez une anosmie sans nez bouché, vous êtes Covid positif, ça n'est pas la peine d'aller vous faire tester.\""
  },
  {
    "picture": "symptom5",
    "title": "Comment détecter un essoufflement correspondant au coronavirus ?",
    "description":
        "L’essoufflement est un autre symptôme du coronavirus qui peut être un signal d'aggravation de la maladie, qui s'attaque aux voies respiratoires et peut déboucher sur une pneumonie sévère. L'essoufflement ne fait pas partie des premiers symptomes du Covid-19. Il s'agit d'une complication qui survient chez certains patients à partir du 7e jour, avec un regain de fièvre, parfois après une légère phase d'amélioration. L'essoufflement arrive souvent de manière subite et se constate au moindre effort physique, comme se déplacer ou montre les escaliers. Pour le détecter si vous avez un doute, mesurez votre fréquence respiratoire. Au delà des 20 à 25 respirations par minutes, il s'agit d'une la tachypnée (augmentation de la fréquence respiratoire) et il peut être conseillé de consulter un médecin si vous présentez d'autres symptômes."
  }
];
