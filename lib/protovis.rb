require 'erb'
 
 
module Protovis
  Redmine::WikiFormatting::Macros.register do
             desc "This is redmine macro for protovis"
             macro :protovis do |obj, args|
                 objname=args[0]
                 data=args[1]
                 Protovis.render("#{File.dirname(__FILE__)}/#{objname}/#{objname}.html",{:data=>data})
              end
           end
  
  def self.render filename,context
  	 
  	 class<<context
  	 	def data
          self[:data]
  	    end
  	 	def get_binding
           binding
  	 	end
  	 end
  	 
  	 begin
     content=File.open(filename,"r").read
  	 ERB.new(content,0).result(context.get_binding)
     rescue Exception => e 
     	e.getMessage
     end

  	 

  end 

end