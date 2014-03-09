require 'rubygems'
require 'sinatra'
require 'json'
require './models/manager'
#require './models/Neo4j_controller'

manjson = Manager.new
manneo = Neo4j_controller.new

get '/' do
  data = {}
  data[:string] = %x{ls Uploads}
  data[:filehash] = manjson.obj_hash
  data[:neo_status] = manneo.status
  erb :main, :locals => {:data => data}
end

post '/del' do 
  if params[:graphname] != nil
    manjson.delete_db(params)
    data = {:message => "#{params[:graphname]} has been deleted."}
    erb :yep, :locals => {:data => data}
  elsif params[:graphname] == nil
    data = {:message => "Nothing to delete."}
    erb :nope , :locals => {:data => data}
  end
end

post '/rebuild' do 
  manjson.rebuild
  data = {:message => "Reality has been established"}
  erb :yep, :locals => {:data => data}
end

post '/load' do 
  data = {}
  if params[:graphname] != nil
    manjson.load(params)
    data[:message] = "#{params[:graphname]} has been loaded"
    erb :yep, :locals => {:data => data}
  elsif params[:graphname] == nil
    data[:message] = "Nothing to load"
    erb :nope, :locals => {:data => data}
  end
end

post '/toggle' do 
  puts params
  data = {}
  if params[:toggle] == "0"
    manneo.neo4j_stop 
    data[:message] = manneo.status_check
  end
  if params[:toggle] == "1"
    manneo.neo4j_start
    data[:message] = manneo.status_check
  end
  erb :yep, :locals => {:data => data}
end

post '/upload' do
  data = {}

  if (params[:uploaded_data][:filename] == "graph.db.tar.gz") && (params[:uploaded_data][:type] == "application/x-gzip") && (params[:graphname].gsub(/[^0-9A-Za-z]/, '').length != 0)
    input = {}    
    input[:filename] = "#{params[:graphname].gsub(/[^0-9A-Za-z]/, '')}" + "#{params[:uploaded_data][:filename]}"
    input[:graphname] = "#{params[:graphname].gsub(/[^0-9A-Za-z]/, '')}"
    input[:path] = params[:uploaded_data][:tempfile].path

    data[:message] = "Upload of #{params[:graphname].gsub(/[^0-9A-Za-z]/, '')} successful"
    manjson.new_upload(input) #uploads
    #manjson.load(input) #loads
    erb :yep, :locals => {:data => data}
  else
    data[:message] = "Upload #{params[:graphname].gsub(/[^0-9A-Za-z]/, '')} unsuccessful"
    erb :nope, :locals => {:data => data}
  end
end
