require './mcp3008'

class Moisture

  def self.get
    Mcp3008.read(0).round
  end
end
