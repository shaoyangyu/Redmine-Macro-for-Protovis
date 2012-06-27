a="[<a:b>]"
class<<a
        def wash
          gsub("<br />","").gsub(" ","").gsub("&lt;","{").gsub("&gt;","}").gsub("<","{").gsub(">","}")
        end
end

p a=a.wash

p a 