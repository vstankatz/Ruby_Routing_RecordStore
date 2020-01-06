require 'spec_helper'

describe '#Album' do


  describe('#save') do
    it("Saves album") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})

      album.save()

      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it('clears all albums') do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})

      album.save()

      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end
#
  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})

      album.save()

      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end
#
  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})

      album.save()
      album.update(:name => "The Black Album", :year => 2001, :genre =>"hiphop", :artist => "old Jay-Z")

      expect(album.name).to(eq("The Black Album"))
      expect(album.artist).to(eq("old Jay-Z"))
    end
  end
#
  describe('#delete') do
    it('deletes an album by id') do
      album = Album.new(:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => nil)
      album.save()
      album2 = Album.new(:name => "Blue", :id =>  nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => nil)
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  # describe('.search') do
  #   it('searches for the given album name') do
  #     Album.clear()
  #     album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
  #     album.save()
  #     album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "aba", :status => nil})
  #     album2.save()
  #     album3 = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre =>"bluegrass", :artist => "old mcdonald", :status => nil})
  #     album3.save
  #     expect(Album.search("giant steps")).to(eq([album, album3]))
  #   end
  # end

#   describe('#sold') do
#     it('removes album from @@albums array and moves it to @@sold_albums') do
#       album = Album.new("Giant Steps", nil, 2000, "bluegrass", "old mcdonald", nil)
#       album.save()
#       album.sold
#       expect(album.status).to(eq("sold"))
#       expect(Album.bought).to(eq([album]))
#     end
#   end
#
end
