for i in 1..17 do
  Week.create(number: i, current: i == 10)
end

for i in 0..3 do
  Player.positions.keys.each do |key|
    Player.create(name: Faker::Name.name, position: key, team: "Panthers", number: rand(1..99))
  end
end