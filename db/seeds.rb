TEAMS = [
  ['Baltimore Orioles', '110'],
  ['Boston Red Sox', '111'],
  ['Los Angeles Angels', '108'],
  ['Chicago White Sox', '145'],
  ['Cleveland Indians', '114'],
  ['Detroit Tigers', '116'],
  ['Kansas City Royals', '118'],
  ['Milwaukee Brewers', '158'],
  ['Minnesota Twins', '142'],
  ['New York Yankees', '147'],
  ['Oakland Athletics', '133'],
  ['Seattle Mariners', '136'],
  ['Texas Rangers', '140'],
  ['Toronto Blue Jays', '141'],
  ['Atlanta Braves', '144'],
  ['Chicago Cubs', '112'],
  ['Cincinnati Reds', '113'],
  ['Houston Astros', '117'],
  ['Los Angeles Dodgers', '119'],
  ['Washington Nationals', '120'],
  ['New York Mets', '121'],
  ['Philadelphia Phillies', '143'],
  ['Pittsburgh Pirates', '134'],
  ['St. Louis Cardinals', '138'],
  ['San Diego Padres', '135'],
  ['San Francisco Giants', '137'],
  ['Colorado Rockies', '115'],
  ['Miami Marlins', '146'],
  ['Arizona Diamondbacks', '109'],
  ['Tampa Bay Rays', '139']
].freeze

TEAMS.each do |team|
  Team.create(name: team[0], mlb_id: team[1])
  puts "Created #{team[0]}!"
end

puts '--------------------'

oldenburg = Person.create(name: 'Adam O.')
puts "Created #{oldenburg.name}"
castanza = Person.create(name: 'Rob C.')
puts "Created #{castanza.name}"
wood = Person.create(name: 'Tori W.')
puts "Created #{wood.name}"
miranda = Person.create(name: 'Mark M.')
puts "Created #{miranda.name}"
lynne = Person.create(name: 'Chris L.')
puts "Created #{lynne.name}"
spanny = Person.create(name: 'Justin S.')
puts "Created #{spanny.name}"
hale = Person.create(name: 'Mike H.')
puts "Created #{hale.name}"
endres = Person.create(name: 'Tony E.')
puts "Created #{endres.name}"
fenzl = Person.create(name: 'Greg F.')
puts "Created #{fenzl.name}"
drake = Person.create(name: 'Andrew D.')
puts "Created #{drake.name}"
mears = Person.create(name: 'Forrest M.')
puts "Created #{mears.name}"
hmiranda = Person.create(name: 'Holly M.')
puts "Created #{hmiranda.name}"
cenizal = Person.create(name: 'Chris C.')
puts "Created #{cenizal.name}"

puts '--------------------'

team = Team.find_by(name: 'Milwaukee Brewers')
team.update(person_id: oldenburg.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'New York Yankees')
team.update(person_id: castanza.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Arizona Diamondbacks')
team.update(person_id: wood.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Los Angeles Dodgers')
team.update(person_id: miranda.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Colorado Rockies')
team.update(person_id: lynne.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'New York Mets')
team.update(person_id: spanny.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Houston Astros')
team.update(person_id: hale.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Cleveland Indians')
team.update(person_id: endres.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Washington Nationals')
team.update(person_id: fenzl.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Cincinnati Reds')
team.update(person_id: drake.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Kansas City Royals')
team.update(person_id: mears.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'Detroit Tigers')
team.update(person_id: hmiranda.id)
puts "Associated #{team.name} with #{team.person.name}"

team = Team.find_by(name: 'San Francisco Giants')
team.update(person_id: cenizal.id)
puts "Associated #{team.name} with #{team.person.name}"
