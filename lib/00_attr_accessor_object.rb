# In the lib/00_attr_accessor_object.rb file, implement a 
# ::my_attr_accessor macro, which should do exactly the same 
#   thing as the real attr_accessor: it should define
#    setter/getter methods.

# To do this, use define_method inside ::my_attr_accessor
#  to define getter and setter instance methods. You'll want
#   to investigate and use the instance_variable_get and
#    instance_variable_set methods described here.

# There is a corresponding spec/00_attr_accessor_object_spec.rb 
# spec file. Run it using bundle exec rspec to check your work.


class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |name|
      define_method(name) do
        instance_variable_get("@#{name}")
      end
      define_method("#{name}=") do |x|
        instance_variable_set("@#{name}", x)
      end
    end
  end
end
