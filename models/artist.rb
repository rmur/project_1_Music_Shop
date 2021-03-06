
require_relative('../db/sql_runner')

class Artist
  attr_accessor :name
  attr_reader :id


  def initialize(params)
    @name = params['name']
    @id = params['id'].to_i if params['id']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;"
    result = SqlRunner.run(sql)
    @id =  result[0]['id'].to_i
  end

  def show()
    sql = "SELECT * FROM artists WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result.map { |hash| Artist.new(hash) }
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    result = SqlRunner.run(sql)
    return result.map { |hash| Album.new(hash)}
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = #{@id}"
    return SqlRunner.run(sql)
  end
  
  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
    result = SqlRunner.run(sql)
    return Artist.new(result.first)

  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map {|hash| Artist.new(hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    return SqlRunner.run(sql)
  end

end