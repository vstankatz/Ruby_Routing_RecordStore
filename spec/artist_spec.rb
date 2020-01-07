require 'spec_helper'

describe '#Artist' do

  describe('#save') do
    it("Saves artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "A Love Supreme", :id => nil})
      artist2.save()
      expect(Artist.all).to(eq([artist, artist2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil, :year => 1990, :genre => "pop", :artist => "John Coltrane", :status => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      # binding.pry
      expect(artist.albums).to(eq([album]))
    end
  end

  describe('#update') do
    it("adds an album to an artist, only if the connection doesn't exist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil, :year => 1990, :genre => "pop", :artist => "John Coltrane", :status => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      album2 = Album.new({:name => "A Love Supreme", :id => nil, :year => 1990, :genre => "pop", :artist => "John Coltrane", :status => nil})
      album2.save()
      artist.update({:album_name => "A Love Supreme"})
      expect(artist.albums).to(eq([album]))
    end
  end

  describe('#albums') do
    it('associates artists with albums') do
    album = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
    album.save()
    artist = Artist.new({:name => "Beyonce", :id => nil})
    artist.save()
    artist.update({:album_name => "Blue"})
    expect(artist.albums).to(eq([album]))
  end
end

describe('.find') do
  it("finds an artist by id") do
    artist = Artist.new({:name => "John Coltrane", :id => nil})
    artist.save()
    artist2 = Artist.new({:name => "Beyonce", :id => nil})
    artist2.save()
    expect(Artist.find(artist.id)).to(eq(artist))
  end
end

describe('#==') do
  it("is the same artist if it has the same attributes as another artist") do
    artist = Artist.new({:name => "John Coltrane", :id => nil})
    artist.save
    artist2 = Artist.new({:name => "John Coltrane", :id => nil})
    artist2.save
    expect(artist).to(eq(artist2))
  end
end

describe('.clear') do
  it('clears all artists') do
    artist = Artist.new({:name => "John Coltrane", :id => nil})
    artist.save()
    artist2 = Artist.new({:name => "Beyonce", :id => nil})
    artist2.save()
    Artist.clear()
    expect(Artist.all).to(eq([]))
  end
end

describe('#delete') do
  it('deletes an artist by id') do
    artist = Artist.new({:name => "Beyonce", :id => nil})
    artist.save()
    artist2 = Artist.new({:name => "Jay-Z", :id => nil})
    artist2.save()
    artist.delete()
    expect(Artist.all).to(eq([artist2]))
  end
end

end
