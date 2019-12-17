require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  # binding.pry
  puts params
    # if params
    #   @albums = Album.add_search
    #
    #   erb(:album)
    # else
      @albums = Album.all
      erb(:albums)
    end

# end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

post('/albums') do
  name = params[:album_name]
  album = Album.new(name, nil, nil)
  new_search = album.add_search
  album = Album.new(name, nil, new_search)
  album.save()
  @albums = Album.all
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @album = Album.add_search
  @albums = Album.all
  erb(:album)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get('/albums?:search') do
  puts "1"
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
