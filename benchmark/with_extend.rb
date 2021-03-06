require File.expand_path('../pure', __FILE__)

class Model
  def name
    :pure
  end
end

module ExtendedUser
  def name
    :extended
  end
end

model = Model.new.extend(ExtendedUser)

benchmark(
  :extended,
  nil,
  -> { Model.new.extend(ExtendedUser).name; NoEffect.new.name },
  nil,
  DEFAULT_CALL,
)
