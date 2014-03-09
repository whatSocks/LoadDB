require 'rubygems'

class Neo4j_controller
  attr_reader :status, :settings

  def initialize
    @status = ""
    @settings = {version: "neo4j-community-2.0.1", path:"../" }
    status_check
  end

  def status_check
    @status = %x{
      cd #{@settings[:path]}#{@settings[:version]}
      ./bin/neo4j status
    }
    @status = @status.chomp
    return @status
  end

  def neo4j_start
    %x{
      cd #{@settings[:path]}#{@settings[:version]}
      ./bin/neo4j start
    }
    status_check
  end

  def neo4j_stop
    %x{
      cd #{@settings[:path]}#{@settings[:version]}
      ./bin/neo4j stop
    }
    status_check
  end
end
