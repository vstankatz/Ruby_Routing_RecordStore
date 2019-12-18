require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  binding.pry
  erb(:albums)
end

get('/albums') do
      @albums = Album.all
      erb(:albums)
    end


get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

post('/albums') do
  name = params[:album_name]
  year = params[:album_year]
  genre = params[:album_genre]
  artist = params[:album_artist]
  album = Album.new(name, nil, year, genre, artist, nil)
  # new_search = album.add_search
  # album = Album.new(name, nil, new_search)
  album.save()
  @albums = Album.all
  erb(:albums)
end


get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  if !params[:name] && !params[:year] && !params[:genre] && !params[:artist]
    @album = Album.find(params[:id].to_i())
    @album.sold()
    @albums = Album.all
    erb(:albums)
  else
    @album = Album.find(params[:id].to_i())
    @album.update(params[:name], params[:year], params[:genre], params[:artist])
    # @album = Album.add_search
    @albums = Album.all
    erb(:album)
  end

end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get('/albums/search/') do
  @album = Album.search(params[:searched])
  erb(:search)
end
