class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    end
    album_name = attributes.fetch(:album_name)
    if album_name != nil
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
       check = DB.exec("SELECT * FROM albums_artists WHERE artist_id = #{@id} AND album_id = #{album['id'].to_i};")
      if album != nil
        if check.any?

        else
        DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
      end
    end
  end

  def ==(artist_to_compare)
    self.name().downcase().eql?(artist_to_compare.name.downcase())
  end

  def albums
    albums = []
    results = DB.exec("SELECT albums.* FROM artists JOIN albums_artists ON (artists.id = albums_artists.artist_id) JOIN albums ON (albums_artists.album_id = albums.id) WHERE artist_id = #{@id};")
    name = results.first().fetch("name")
    year = results.first().fetch("year")
    genre = results.first().fetch("genre")
    artist = results.first().fetch("artist")
    status = results.first().fetch("status")
    album_id = results.first().fetch("id")
    albums.push(Album.new({:name => name, :id => album_id, :year => year, :genre => genre, :artist => artist,  :status => status}))
    albums
  end

  def self.find (id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id}").first
    name = artist.fetch("name")
    id = artist.fetch("id").to_i
    Artist.new({:name => name, :id => id})
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

end
