require 'rexml/document'
include REXML
module Puppet::Parser::Functions
    newfunction(:getServerOptions, :type => :rvalue ) do |args|
        doc = REXML::Document.new args[0]
        nodecount = REXML::XPath.first(doc, "count("+ args[1]+")")
	presence = false
	if ( nodecount >= 1)
        	presence = true
	end
	return presence
    end
end
