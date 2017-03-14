module Reality
  def Reality.wikipedia
    @wikipedia ||= DataSources::MediaWiki.new(:wikipedia, 'https://en.wikipedia.org/w/api.php')
  end
end

# NB: those first lambdas should be thought like XPath/CSS statements. But Ruby lambdas.
# Any MORE declarative approach is highly appreciated.

Reality.wikipedia.on(
  ->(p) { p.templates(name: 'Infobox country').fetch('conventional_long_name') },
  :long_name,
  :as_string
)

Reality.wikipedia.on(
  ->(p) { p.templates(name: /^Infobox/).fetch('coordinates').tempates(name: 'Coord') },
  :coord,
  :as_coord_from_array
)

Reality.wikipedia.on(
  ->(p) { p.templates(name: /^Infobox/).fetch('area_km2') },
  :area,
  :as_measure,
  unit: :km2
)

Reality.wikipedia.on(
  ->(p) { p.templates(name: /^Infobox/).fetch('population_census') },
  :area,
  :as_measure,
  unit: :person
)

Reality.wikipedia.on(
  ->(p) { p.templates(name: /^Infobox/).fetch('capital') },
  :area,
  :as_link
)