f_infotext <- function(data_kind){
  ## function to return information text about opensource data
  # - data_kind: character; defines about what the information text should be
  #                         options: "icond2" -> forecast model ICON D2
  #                                  "mess"   -> measurement surface data
  #                                  "pheno"  -> phenology data
  
  if (data_kind == "icond2"){
    showNotification(tags$p("ICON-D2 ist ein numerisches Modell f\u00FCr die Wetterprognose. Die
    Vorhersagen werden sechs Mal t\u00E4glich durch den Deutschen Wetterdienst berechnet und
    \u00F6ffentlich zur Verf\u00FCgung gestellt. Weitere Informationen zu diesem Wettermodell 
                            finden Sie ", tags$a("hier.", href="https://www.dwd.de/DE/forschung/wettervorhersage/num_modellierung/01_num_vorhersagemodelle/regionalmodell_icon_d2.html?nn=512942", target= "_blank"),
                            tags$br(),tags$br(),
                            "Auf dieser Website abrufbar sind Vorhersagen f\u00FCr die 
                            vier von ICON-D2 berechneten Parameter Niederschlag, Temperatur, Bew\u00F6lkung und Druck. 
                            Die Vorhersagen werden hier sowohl zweidimensional
                            auf der Karte als auch eindimensional als Punktvorhersage
                            dargestellt. Der Ort f\u00FCr die Punktvorhersage l\u00E4sst
                            sich auf drei verschiedene Arten bestimmen. Die erste
                            Option 'Mausklick' bedeutet, dass die Punktvorhersage
                            f\u00FCr einen beliebigen auf der Karte angeklickten Punkt
                            erstellt wird. Die zweite Option 'Landeshauptstadt'
                            erstellt die Punktvorhersage f\u00FCr die Landeshauptstadt
                            des ausgew\u00E4hlten Bundeslandes. Bei der dritten Option
                            'freie Koordinatenwahl' kann das Koordinatenpaar f\u00FCr
                            die Punktvorhersage manuell eingegeben werden.",
                            tags$br(),tags$br(),
                            "Der Prognosebereich von ICON-D2 umfasst Deutschland
                            sowie Teile der angrenzenden L\u00E4nder. Die genaue Begrenzung
                            ist auf der Karte durch die blaue Markierung ersichtlich.")
                     ,duration = NULL)
  }else if (data_kind == "mess"){
    showNotification(tags$p("Die Messdaten der Bodenparameter, wie beispielsweise
                     Temperatur oder Niederschlag, werden f\u00FCr Deutschland vom 
                     Deutschen Wetterdienst durch dessen Bodenmessnetz erfasst und
                     \u00F6ffentlich zur Verf\u00FCgung gestellt. Die Messstationen laufen
                     nach den internationalen Richtlinien der WMO (World Meteorological
                     Organization). Weiter Informationen dazu finden Sie ", tags$a("hier.", href="https://www.dwd.de/DE/derdwd/messnetz/bodenbeobachtung/_functions/Teasergroup/bodenmessnetz.html?nn=452720", target= "_blank"),
                            tags$br(),tags$br(),
                            "Auf dieser Website abrufbar sind sowohl die Messwerte des aktuellen Tages
                            (Aufl\u00F6sung 10-Minuten) als auch Tageswerte und Monatswerte. Die abrufbaren Parameter
                            variieren je nach Aufl\u00F6sung der Messdaten abh\u00E4ngig von deren Verf\u00FCgbarkeit.
                            Es k\u00F6nnen hier die Messwerte f\u00FCr maximal f\u00FCnf Messstationen
                            gleichzeitig dargestellt werden. \u00DCber die Eingabe 'Parameter
                            f\u00FCr Plot 1' und 'Parameter f\u00FCr Plot 2' ist w\u00E4hlbar,
                            welche Parameter in welchem Plot dargestellt werden.")
                     ,duration = NULL)
  } else if (data_kind == "pheno"){
    showNotification(tags$p("Das ph\u00E4nologische Messnetz des Deutschen Wetterdienstes erfasst
                     die Entwicklungsstufen einiger Pflanzenarten und stellt diese
                     \u00F6ffentlich zur Verf\u00FCgung. Weitere Informationen dazu finden Sie ", tags$a("hier", href="https://www.dwd.de/DE/klimaumwelt/klimaueberwachung/phaenologie/phaenologie_node.html", target="_blank"),
                     "oder", tags$a("hier.", href="https://www.dwd.de/DE/derdwd/messnetz/bodenbeobachtung/_functions/Teasergroup/phaenologie.html;jsessionid=E0C5A71A618B415EB6FE934E7E579586.live21062?nn=452720", target="_blank"),
                     tags$br(),tags$br(),
                     "Je nach Pflanzenart werden unterschiedliche Entwicklungsstufen
                      (ph\u00E4nologische Phasen) registiert. Hier dargestellt werden k\u00F6nnen
                      alle diese Pflanzenarten und Phasen je Station. Erscheint eine
                      Station trotz Auswahl nicht im Plot, sind f\u00FCr die
                      ausgew\u00E4hlte Pflanzenart und Phase an dieser Station keine
                      Daten vorhanden.",
                     tags$br(),tags$br(),
                     "Es k\u00F6nnen die Daten f\u00FCr mehrere Stationen gleichzeitig angezeigt werden,
                      indem unter Stationsname/n mehrere Stationen ausgew\u00E4hlt werden. 
                      Durch das Setzen entsprechender H\u00E4ckchen unter 'Hilfslinien' werden zus\u00E4tzliche
                     Linien zur besseren Lesbarkeit der dargestellten Daten angezeigt. 
                     In der Karte unter dem Plot wird die genaue Lage der Station/en
                     durch einen Punkt in derselben Farbe wie die der zugeh\u00F6rigen Messdaten im Plot
                     gekennzeichnet."),
                     duration = NULL)
  }
}