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
  'su' => {  path    => "/home/ubuntu/su",
               ensure  => present,
               content => "suhan",
               require =>  Fill_templates[$configFileDetails], },
  'ma'  => { path    => "/home/ubuntu/ma",
               ensure  => present,
               content => "malintha",
               require =>  Fill_templates[$configFileDetails], },
}

                return myfiles
        end
end

