require 'blue_print'

class BluePrint::ActiveIf
  NAMED_ACTIVE_IFS_MAP = {}

  def self.resolve(name)
    if name.respond_to?(:active?)
      name
    else
      NAMED_ACTIVE_IFS_MAP[name.to_s.to_sym]
    end
  end

  def initialize(name = nil, &logic)
    @name = name
    @logic = logic

    NAMED_ACTIVE_IFS_MAP[name] = self unless anonymous?
  end

  def name
    @name ? @name.to_s.to_sym : nil
  end

  def anonymous?
    name.nil?
  end

  def cache_key
    @cache_key ||= "blue_print_active_id_#{name || object_id}".to_sym
  end

  def active?
    return BluePrint.env[cache_key] if BluePrint.env.key?(cache_key)

    BluePrint.env[cache_key] = BluePrint.env.within(&@logic)
  end

  def deactive?
    !active?
  end
end
