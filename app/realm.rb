Realm = RLMRealm
Results = RLMResults
RealmArray = RLMArray

[Results, RealmArray].each { |k| k.send(:include, Enumerable) }

class RealmObject < RLMObject
  class << self
    PROPERTY_TYPES = {
      Integer => RLMPropertyTypeInt
    }.freeze

    def realm_properties
      @realm_properties ||= []
    end

    def realm_attr_accessor(name, type, opts = {})
      object_class_name = type.name if type < RealmObject
      raise 'Must give a type' unless PROPERTY_TYPES.keys.include?(type) || type < RealmObject
      type = PROPERTY_TYPES[type]
      indexed = opts[:indexed] || false

      if opts[:primary]
        define_method(:primaryKey) do
          name
        end
      end
      type = RLMPropertyArray if !type && opts[:to_many]
      type = RLMPropertyTypeObject if object_class_name
      property = RLMProperty.alloc.initWithName(name, type: type, objectClassName: object_class_name, indexed: indexed)
      realm_properties << property
    end

    private def klasses
      @klasses ||= []
    end

    def createSharedSchema
      self == RealmObject ? nil : super
    end

    def objectSchemaProperties(isSwift)
      return self.realm_properties
    end
  end
end
