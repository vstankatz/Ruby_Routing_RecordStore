class Album
  attr_reader :id, :name, :year, :genre, :artist

  @@albums = {}
  @@total_rows = 0
  def initialize(name, id, year, genre, artist)
    @name = name
    @id = id || @@total_rows += 1
    @year = year
    @genre = genre
    @artist = artist
  end

  # def add_search
  #   @search = "search=#{@name.split(' ').join('+')}"
  # end

  def self.all()
    @@albums.values()
  end

  def save()
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
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

  def update(name, year, genre, artist)
    @name = name
    @year = year
    @genre = genre
    @artist = artist
  end

  def delete
    @@albums.delete(self.id)
  end

end
