require 'erb'
require 'digest/sha2' 
 
module Protovis
  Redmine::WikiFormatting::Macros.register do
             desc "This is redmine macro for protovis"
             macro :protovis do |obj,args|
                 data=Protovis.parse(args)
                 Protovis.render("#{File.dirname(__FILE__)}/#{data.objname}/#{data.objname}.html",data)
              end
           end

  def self.parse(args)  
  	data={}
  	data[:objname],data[:width],data[:height]=args
  	data[:data]=args[3..-1].join(",").strip!
  	data[:data]=data[:data].gsub("&lt;","{")
    data[:data]=data[:data].gsub("&gt;","}")
    data[:data]=data[:data].gsub("<br />","")
    p data[:data]
    data[:data]=ActiveSupport::JSON.decode(data[:data])
    data[:data]=ActiveSupport::JSON.encode(data[:data])
    data[:id]=Digest::SHA256::hexdigest(data[:data])
    puts "log-->JSON String is :"+data[:data]
  	class<<data
  		def method_missing(method,*args,&block)
	 	  self[method]
	    end
	    def get_binding
           binding
  	 	end
  	end
    data
  end	
 

  def self.render filename,context
  	 begin
     content=File.open(filename,"r").read
  	 ERB.new(content,0).result(context.get_binding)
     rescue Exception => e 
     	e.to_s
     end
  end 

 
  

end