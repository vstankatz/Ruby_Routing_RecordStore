class Album
  attr_reader :id, :name, :search

  @@albums = {}
  @@total_rows = 0
  def initialize(name, id, search)
    @name = name
    @id = id || @@total_rows += 1
    @search = search
  end

  def add_search
    @search = "search=#{@name.split(' ').join('+')}"
  end

  def self.all()
    @@albums.values()
  end

  def save()
    @@albums[self.id] = Album.new(self.name, self.id, self.search)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  # def self.search(album_name)
  #   fetch from the hash:
  #     an album where the @search == album_name
  # end

  def update(name)
    @name = name
  end

  def delete
    @@albums.delete(self.id)
  end

end
