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

  def delete()
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
      })
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
      })
    sql = "UPDATE bounties
      SET (name,
           species,
           last_known_location,
           bounty_value)
      = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @species, @last_known_location, @bounty_value, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end





  def Bounty.all()
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
    })
    sql = "SELECT * FROM bounties;"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map {|bounty| Bounty.new(bounty)}
  end

  def Bounty.delete_all()
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
      })
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({
      dbname: "bounty_list",
      host: "localhost"
      })
    sql = "SELECT * FROM bounties WHERE name = $1;"
    values = [name]
    db.prepare("find_by_name", sql)
    results_array = db.exec_prepared("find_by_name", values)
    bounty_hash = results_array[0]
    bounty = Bounty.new(bounty_hash)
    db.close()
    return bounty
  end

  # def Bounty.find_by_id(id)
  #   db = PG.connect({
  #     dbname: "bounty_list",
  #     host: "localhost"
  #     })
  #   sql = "SELECT * FROM bounties WHERE name = $1;"
  #   values = [id]
  #   db.prepare("find_by_id", sql)
  #   results_array = db.exec_prepared("find_by_id", values)
  #   bounty_hash = results_array[0]
  #   bounty = Bounty.new(bounty_hash)
  #   db.close()
  #   return bounty
  # end


end
