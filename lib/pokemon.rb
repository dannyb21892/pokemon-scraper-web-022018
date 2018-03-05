require "pry"
class Pokemon
  attr_accessor :name, :type, :hp
  attr_reader :id, :db

  def initialize(id: nil, name: nil, type: nil, hp: nil, db: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    stats = db.execute(sql, id).flatten
    hash = {id: stats[0], name: stats[1], type: stats[2], hp: stats[3], db: db}
    out = Pokemon.new(hash)
  end

  def alter_hp(hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE id = ?"
    db.execute(sql, hp, self.id)
  end
end
