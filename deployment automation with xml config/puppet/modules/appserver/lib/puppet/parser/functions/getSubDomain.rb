require 'rexml/document'
include REXML
module Puppet::Parser::Functions
    newfunction(:getSubDomain, :type => :rvalue ) do |args|
        doc = REXML::Document.new args[0]
        subDomain = doc.elements["node/subDomain"].text
        return subDomain
    end
end

