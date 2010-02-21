require 'logger'

module GrowlRubyApi
  # GrowlLogger is an implementation of Logger that uses GrowlRubyApi::Growl to
  # do the logging.
  #
  # Usage: Create an instance of GrowlLogger passing configuration args to the
  # constructor or a previously instantiated instance of GrowlRubyApi::Growl.
  # Use as you would any other logger.
  #
  # ==== Example
  #
  #     logger = GrowlLogger.new(
  #         :default_app => "ClamAV Scan Report", 
  #         :default_title => "ClamAV", 
  #         :default_image_type => :image_file, 
  #         :default_image => "images/notify.gif"
  #     )
  #     logger.level = Logger::DEBUG
  #     logger.warn("Using GrowlLogger")
  class GrowlLogger < Logger
    # call-seq:
    #   GrowlLogger.new() => Logger instance configured with defaults
    #   GrowlLogger.new(:growl => growl) => Growl instance using the provided growl 
    #   instance
    #
    # Constructs a new instance of GrowlLogger in additon to the options available
    # to GrowlRubyApi::Growl the following options are available.
    #
    # ==== Options
    #
    # * <tt>:growl</tt> - an instance of GrowlRubyApi::Growl
    #     passes @growl into the logger implementation
    # * <tt>:level</tt> - a standard Logger level
    #     set the log level of this logger instance to @level
    # * <tt>:datetime_format</tt> - standard logger datetime format string
    #     set the datetime_format to @datetime_format
    def initialize(options = {})
      growl = options[:growl] || Growl.new(options)
      super(GrowlLogger::Device.new(growl))
      self.level = options[:level] if options[:level]
      self.datetime_format = options[:datetime_format] || '%X'
      self.formatter = lambda { |severity, time, progname, message| "#{severity}: #{message}" }
    end
    
    class Device
      def initialize(growl)
        @growl = growl
      end
      
      def write(message)
        priority = get_priority(message)
        @growl.notify(message, :priority => priority)
      end
      
      def get_priority(message)
        case message
        when /^D/
          -2
        when /^I/
          -1
        when /^W/
          0
        when /^E/
          1
        when /^F/
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