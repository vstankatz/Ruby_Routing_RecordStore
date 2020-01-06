require 'spec_helper'

describe '#Song' do



  describe('#==') do
    it("is the same song if it has the same attributes as another song") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song2.save()
      expect(song).to(eq(song2))
    end
  end
#
  describe('.all') do
    it("returns a list of all songs") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song2.save()
      expect(Song.all).to(eq([song, song2]))
    end
  end
#
  describe('.clear') do
    it("clears all songs") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song2.save()
      Song.clear()
      expect(Song.all).to(eq([]))
    end
  end
#
  describe('#save') do
    it("saves a song") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song.save()
      expect(Song.all).to(eq([song]))
    end
  end
#
  describe('.find') do
    it("finds a song by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song2.save()
      expect(Song.find(song.id)).to(eq(song))
    end
  end
#
  describe('.find_by_album') do
    it("finds songs for an album") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song2.save()
      expect(Song.find_by_album(album.id)).to(eq([song, song2]))
    end
  end
#
  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song2 = Song.new(:name => "Naima", :album_id => album.id, :id => nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end

  describe('#album') do
  it("finds the album a song belongs to") do
    album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
    album.save()
    song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
    song.save()
    expect(song.album()).to(eq(album))
  end
end

  describe('#update') do
    it("updates an song by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
      album.save()
      song = Song.new(:name => "Giant Steps", :album_id => album.id, :id => nil)
      song.save()
      song.update(:name => "Mr. P.C.", :album_id => album.id)
      expect(song.name).to(eq("Mr. P.C."))
    end
  end
#
describe('#delete') do
  it("deletes all songs belonging to a deleted album") do
    album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
    album.save()
    song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
    song.save()
    album.delete()
    expect(Song.find(song.id)).to(eq(nil))
  end
end
end
