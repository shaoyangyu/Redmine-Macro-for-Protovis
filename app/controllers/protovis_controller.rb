class ProtovisController < ApplicationController
  unloadable


  def index
  	 @templates=Template.all
  end

  def service
     #retrieve the POST data
     wrData=params["wrData"]
     wrData=ActiveSupport::JSON.decode(wrData) 
     op=wrData["op"]
     data=wrData["data"]

     #do action according to the op
     if(op=="find")
     @result=Template.all
     end

     if(op=="create")
      @result=Template.new(data)  
      @result.save
     end

     if(op=="save")
      entity=Template.find(data["id"])  
      entity.update_attributes(data)
     end	

     if(op=="delete")
      entity=Template.find(data["id"])
      entity.delete
     end

     render :json=>@result
  end

end
