=begin
    Copyright 2010-2015 Tasos Laskos <tasos.laskos@arachni-scanner.com>

    This file is part of the Arachni Framework project and is subject to
    redistribution and commercial restrictions. Please see the Arachni Framework
    web site for more information on licensing and terms of use.
=end

module Arachni
module HTTP
class ProxyServer

# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Tunnel < Arachni::Reactor::Connection
    include Arachni::UI::Output
    personalize_output

    def initialize( options )
        print_debug_level_2 'New SSL tunnel.'

        @client = options[:client]
    end

    def on_connect
        print_debug_level_2 'Connected to Interceptor.'
    end

    def write( data )
        print_debug_level_2 " -> Forwarding #{data.size} bytes to Interceptor."
        super data
    end

    def on_close( reason = nil )
        print_debug_level_2 "Closed because: [#{reason.class}] #{reason}"

        # ap self.class
        # ap 'CLOSE'
        # ap reason

        # @other_end.close reason
    end

    def on_read( data )
        # ap self.class
        # ap 'READ'
        # ap data
        print_debug_level_2 "<- Forwarding #{data.size} bytes to client."
        @client.write data
    end
end

end
end
end
