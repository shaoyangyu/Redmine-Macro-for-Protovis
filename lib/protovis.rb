require 'erb'
require 'digest/sha2' 
#######################################
#   Author shaoyang
#   email:yushaoyang@WindRoader.com
#   @createddate 2012-06-27 21:44:59 +0800
#######################################
module Protovis
  Redmine::WikiFormatting::Macros.register do
             desc "This is redmine macro for protovis"
             macro :protovis do |obj,args|
                 data=Protovis.parse(args)
                 Protovis.render(data)
              end
           end

  def self.parse(args)  
  	data={}
  	data[:objname],data[:width],data[:height]=args
  	data[:data]=args[3..-1].join(",")
    class<<data[:data]
        def wash
          gsub("<br />","").gsub(" ","").gsub("&lt;","{").gsub("&gt;","}").gsub("<","{").gsub(">","}")
        end
    end
  	data[:data]=data[:data].wash

    data[:id]=Digest::SHA256::hexdigest(data[:data])
    #puts "---------------------------------------"
    #puts "log-->JSON String is-> "+data[:data]
    #puts "---------------------------------------"
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
 

  def self.render context
  	 begin
     if context.objname.include?("sample_") 
     #use sample template from lib folder
       name=context.objname.split("sample_",2).last
       filename="#{File.dirname(__FILE__)}/#{name}/#{name}.html"
       content=File.open(filename,"r").read
     else
     #load template from db
     template=""
     content=template.content if not (template=Template.find_by_name(context.objname)).nil? 
     p "-----------------------"
     p content
     p "-----------------------"     
     end
     
  	 ERB.new(content,0).result(context.get_binding)
     rescue Exception => e 
     	e.to_s
     end
  end 

 
  

end