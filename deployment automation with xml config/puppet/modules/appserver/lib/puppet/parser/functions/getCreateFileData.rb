require 'rexml/document'
include REXML
module Puppet::Parser::Functions
        newfunction(:getCreateFileData, :type => :rvalue ) do |args|
                fileDetails= []
                doc = REXML::Document.new args[0]
                doc.elements.each("node/create/file") {
                |filedata|
                        fileName= filedata.elements["filename"].text
                        fileLocation= filedata.elements["location"].text
                        fileContent= filedata.elements["content"].text
                        fileDetails << {'filename' => fileName, 'filelocation'=> fileLocation, 'filecontent'=> fileContent }
                }
	myfiles = {
  'nick' => {  path    => "/home/ubuntu/nick",
               ensure  => present,
               content => "malintha",
               require =>  Fill_templates[$configFileDetails], },
  'dan'  => { path    => "/home/ubuntu/dan",
               ensure  => present,
               content => "malintha",
               require =>  Fill_templates[$configFileDetails], },
}

                return myfiles
        end
end

