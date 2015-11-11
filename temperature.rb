require './mcp3008'

class Temperature

  def self.get
    Mcp3008.read(1) * 2.45
  end
end
