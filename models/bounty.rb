require("pg")

class Bounty

  attr_accessor(:name, :species, :last_known_location, :bounty_value)

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @name = options["name"]
    @species = options["species"]
    @last_known_location = options["last_known_location"]
    @bounty_value = options["bounty_value"].to_i()
  end

  def save()
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
      })
    sql = "INSERT INTO bounties (
      name,
      species,
      last_known_location,
      bounty_value)
      VALUES (
      $1, $2, $3, $4)
      RETURNING id;"
    values = [@name, @species, @last_known_location, @bounty_value]
    db.prepare("save", sql)
    id_hash = db.exec_prepared("save", values).first()
    @id = id_hash["id"].to_i()
    db.close()
  end



end
