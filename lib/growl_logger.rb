require 'logger'

module GrowlRubyApi
  class GrowlLogger < Logger
    def initialize(args = {})
      super(GrowlLogger::Device.new(args))
    end
    
    class Device
      def initialize(args)
        @growl = Growl.new(args)
      end
      
      def write(message)
        priority = get_priority(message)
        @growl.notify(message)
      end
      
      def get_priority(message)
        case message
        when /^DEBUG/
          -2
        when /^INFO/
          -1
        when /^WARN/
          0
        when /^ERROR/
          1
        when /^FATAL/
          2
        else
          0
        end
      end
      
      def close
      end
    end
  end
end