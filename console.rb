require("pry")
require_relative("models/bounty.rb")

bounty1 = Bounty.new({
  "name" => "Horza",
  "species" => "Changer",
  "last_known_location" => "Schar's World",
  "bounty_value" => "10_000"
  })


  bounty2 = Bounty.new({
    "name" => "Ziller",
    "species" => "Chelgrian",
    "last_known_location" => "Masaq Orbital",
    "bounty_value" => "20_000"
    })


    binding.pry
    nil
