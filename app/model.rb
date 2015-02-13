class Model < RealmObject
  realm_attr_accessor :int, Integer
  realm_attr_accessor :link, Model
end
