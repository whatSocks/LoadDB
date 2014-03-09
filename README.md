LoadDB
=====
This is a simple graph.db management application built in Sinatra. 

Place load.db adjacent to your instance of Neo4j (here the instance is neo4j-community-2.0.1) `bundle install` to deal with your gems and `rackup` to start the web application. 
Tar and compress the graph.db file you want to upload (`tar -zcvf graph.db.tar.gz graph.db`) and use the form to upload and label the file.
The graph.db.tar.gz files will be stored in the "Uploads" folder, and named like `[user-generated label]graph.db.tar.gz`. 

Use the **Load** and **Delete** fields to load and delete files from the upload folder. 
**Load** will stop and restart Neo4j with the selected graph.db.
**Delete** will remove the graph.db from the list of loadable graph.dbs, but will not interrupt Neo4j. 

**Rebuild** regenerates the list of graph.dbs based on the occupants of the Uploads folder. 

**Toggle** turns Neo4j on or off. 

If you're using a different path or Neo4j version, you can change adjust your settings under /models/neo4j-controller.rb:

`@settings = {version: "neo4j-community-2.0.1", path:"../" }`

TODO:
-----
 - rspec
 - consolidate the yep and nope views
