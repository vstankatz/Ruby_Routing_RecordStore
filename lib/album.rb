class Album
  attr_reader :id, :name, :year, :genre, :artist, :status

  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0
  def initialize(name, id, year, genre, artist, status)
    @name = name
    @id = id || @@total_rows += 1
    @year = year
    @genre = genre
    @artist = artist
    @status = "available"
  end


  def self.all()
    @@albums.values()
  end

  def self.bought()
    @@sold_albums.values()
  end


  def save()
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist, self.status)
  end

  def ==(album_to_compare)
    self.name().downcase().eql?(album_to_compare.name.downcase()) && self.artist().downcase().eql?(album_to_compare.artist.downcase())
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def self.search(album_name)
    return_array = @@albums.values.select { |album| album.name.downcase == album_name.downcase }
    if return_array == []

    else
      return_array.sort_by(&:year)
    end
  end

  def songs
  Song.find_by_album(self.id)
end

  def update(name, year, genre, artist)
    @name = name
    @year = year
    @genre = genre
    @artist = artist
  end

  def delete
    @@albums.delete(self.id)
  end

  def sold

    @status = "sold"
    @@sold_albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist, self.status)
  end

end
