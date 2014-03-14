LoadDB
=====
This is a simple graph.db management application built in Ruby/Sinatra. 

If you don't have Ruby and Bundler installed, do so now. 

**Getting Started**

 - Place LoadDB adjacent to your instance of Neo4j (here the instance is neo4j-community-2.0.1). 
 - `bundle install` to deal with your gems
 - `rackup` to start the Sinatra web application
 - Tar and compress the graph.db file you want to upload (`tar -zcvf graph.db.tar.gz graph.db`)
 - Use the web application to upload and label the file

The graph.db.tar.gz files will be stored in the "Uploads" folder, named like `[user-generated label]graph.db.tar.gz`. 

**Functionality**

 - **Load** will stop and restart Neo4j with the selected graph.db.
 - **Delete** will remove the graph.db from the list of loadable graph.dbs, but will not interrupt Neo4j. 
 - **Rebuild** regenerates the list of graph.dbs based on the occupants of the Uploads folder. 
 - **Toggle** turns Neo4j on or off. 
 - **Save** saves whatever graph.db Neo4j is using at the moment. Make sure to give your snapshot a name. 

**Adjusting Settings**

If you're using a different path or Neo4j version, you can change adjust your settings under /models/neo4j_controller.rb:

`@settings = {version: "neo4j-community-2.0.1", path:"../" }`

TODO:
-----
 - rspec
 - Fix fail when no graph.db.tar.gz file is selected for upload
