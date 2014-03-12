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
    data = {:message => "#{params[:graphname]} has been deleted.", :header => "Success"}
  elsif params[:graphname] == nil
    data = {:message => "Nothing to delete.", :header => "Success...sorta"}
  end
  erb :response, :locals => {:data => data}
end

post '/rebuild' do 
  manjson.rebuild
  data = {:message => "Reality has been established", :header => "Success"}
  erb :response, :locals => {:data => data}
end

post '/load' do 
  data = {}
  if params[:graphname] != nil
    manjson.load(params)
    data[:message] = "#{params[:graphname]} has been loaded"
    data[:header] = "Success"
  elsif params[:graphname] == nil
    data[:message] = "Nothing to load"
    data[:header] = "Success...sorta"
  end
  erb :response, :locals => {:data => data}
end

post '/toggle' do 
  data = {:header => "Status"}
  if params[:toggle] == "0"
    manneo.neo4j_stop 
    data[:message] = manneo.status_check
  end
  if params[:toggle] == "1"
    manneo.neo4j_start
    data[:message] = manneo.status_check
  end
  erb :response, :locals => {:data => data}
end

post '/save' do 
  data = {:header => "Status"}
  manjson.save_db(params)
  data[:message] = "Current graph.db should be saved"
  erb :response, :locals => {:data => data}
end

post '/upload' do
  puts params 
  data = {:header => "Upload"}

  if (params[:uploaded_data][:filename] == "graph.db.tar.gz") && (params[:graphname].gsub(/[^0-9A-Za-z]/, '').length != 0) && (params[:uploaded_data][:type] == "application/x-gzip")
    input = {}    
    input[:filename] = "#{params[:graphname].gsub(/[^0-9A-Za-z]/, '')}" + "#{params[:uploaded_data][:filename]}"
    input[:graphname] = "#{params[:graphname].gsub(/[^0-9A-Za-z]/, '')}"
    input[:path] = params[:uploaded_data][:tempfile].path

    data[:message] = "Upload of #{params[:graphname].gsub(/[^0-9A-Za-z]/, '')} successful"
    manjson.new_upload(input) #uploads
    #manjson.load(input) #loads
  else
    data[:message] = "Upload #{params[:graphname].gsub(/[^0-9A-Za-z]/, '')} unsuccessful"
  end
  erb :response, :locals => {:data => data}
end
