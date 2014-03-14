require 'spec_helper'

describe <%= class_name %>Context::<%= @role %> do
  before { <%= class_name %>Context.stub(active?: true) }
end
