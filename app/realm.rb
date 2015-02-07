class Realm
  private

  attr_accessor :rlm_realm

  public

  def initialize(path, key = nil, read_only = false)
    schema = RLMSchema.new
    schema.objectSchema = RealmObject.klasses.map do |klass|
      RLMObjectSchema.alloc.initWithClassName(klass.name, objectClass: RLMObjectBase, properties: klass.realm_properties)
    end
    @rlm_realm = RLMRealm.realmWithPath(path, key: key, readOnly: read_only, inMemory: false, dynamic: true, schema: schema, error: nil)
  end

  def self.default
    new(RLMRealm.defaultRealmPath)
  end

  def method_missing(method, *args, &block)
    rlm_realm.respond_to?(method) ? rlm_realm.send(method, *args, &block) : super
  end
end

# class RealmObject < RLMObjectBase
#   unless self == RealmObject
#     klasses < self
#   end
#
#   class << self
#     def realm_properties
#       @realm_properties ||= []
#     end
#
#     def realm_attr_accessor(name, type, opts = {})
#       realm_properties << RLMProperty.alloc.initWithName(name, type: RLMPropertyTypeInt, objectClassName: nil, indexed: false)
#     end
#
#     private def klasses
#       @klasses ||= []
#     end
#   end
# end

module RealmObject
  module ClassMethods
    def realm_properties
      @realm_properties ||= []
    end

    def realm_attr_accessor(name, type, opts = {})
      RLMProperty.alloc.init
      realm_properties << RLMProperty.alloc.initWithName(name, type: RLMPropertyTypeInt, objectClassName: nil, attributes: 0)
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    klasses << base if base.is_a?(Class)
  end

  def self.klasses
    @klasses ||= []
  end
end
