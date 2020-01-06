class Album
  attr_reader :id, :name, :year, :genre, :artist, :status
  attr_accessor :name

  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @year = attributes.fetch(:year)
    @genre = attributes.fetch(:genre)
    @artist = attributes.fetch(:artist)
    @status = attributes.fetch(:status) || nil
    if @status === nil
      @status = "available"
    end
  end


  def self.all
  returned_albums = DB.exec("SELECT * FROM albums;")
  albums = []
  returned_albums.each() do |album|
    name = album.fetch("name")
    id = album.fetch("id").to_i
    year = album.fetch("year")
    genre = album.fetch("genre")
    artist = album.fetch("artist")
    status = album.fetch("status")
    albums.push(Album.new({:name => name, :id => id, :year => year, :genre => genre, :artist => artist, :status => status}))
  end
  albums
end

  def self.bought()
    @@sold_albums.values()
  end

  def save
    result = DB.exec("INSERT INTO albums (name, year, genre, artist, status) VALUES ('#{@name}', '#{@year}', '#{@genre}', '#{@artist}', '#{@status}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
 ## Make sure this works, it doesnt take in anything but name!

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
