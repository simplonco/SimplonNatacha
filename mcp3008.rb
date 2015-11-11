require 'pi_piper'

class Mcp3008
  @clock = PiPiper::Pin.new :pin => 18, :direction => :out
  @adc_out = PiPiper::Pin.new :pin => 23
  @adc_in = PiPiper::Pin.new :pin => 24, :direction => :out
  @cspin = PiPiper::Pin.new :pin => 25, :direction => :out

  def self.read(adc_pin)
    @cspin.on
    @clock.off
    @cspin.off
    
    command_out = adc_pin
    command_out |= 0x18
    command_out <<= 3

    (0..4).each do
      @adc_in.update_value((command_out & 0x80) > 0)
      command_out <<= 1
      @clock.on
      @clock.off
    end
    result = 0

    (0..11).each do
      @clock.on
      @clock.off
      result <<= 1
      @adc_out.read
      if @adc_out.on?
        result |= 0x1
      end
    end 

    @cspin.on

    ((result >> 1) / 1023.0 * 100).to_i
  end
end

