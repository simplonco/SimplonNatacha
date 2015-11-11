require 'pi_piper'

class Pump
  @pin = PiPiper::Pin.new(pin: 21, direction: :out)

  def self.open(time)
    start
    sleep time
    stop
    nil 
  end
  
  def self.start
    @pin.on
  end

  def self.stop
    @pin.off
  end
end

