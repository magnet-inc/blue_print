# BluePrint

[![Gem Version](https://badge.fury.io/rb/blue_print.png)](http://badge.fury.io/rb/blue_print)
[![Build Status](https://travis-ci.org/magnet-inc/blue_print.png?branch=master)](https://travis-ci.org/magnet-inc/blue_print)
[![Coverage Status](https://coveralls.io/repos/magnet-inc/blue_print/badge.png)](https://coveralls.io/r/magnet-inc/blue_print)
[![Code Climate](https://codeclimate.com/github/magnet-inc/blue_print.png)](https://codeclimate.com/github/magnet-inc/blue_print)

The behavior switching framework.

## Requirements

- __Ruby__ >= _2.0.0_
  - Tested ruby version:
    - 2.0.0
    - 2.1.0
    - 2.1.1
    - head

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blue_print', '~> 1.2.0'
```

## Usage

### Integration

BluePrint provides some integrations. Now supported libraries:

- [Ruby on Rails](http://rubyonrails.org/) >= 3.1
- [Grape](http://intridea.github.io/grape/)
- [Draper](https://github.com/drapergem/draper)
- [RSpec](https://github.com/rspec)

### Rails Generators

BluePrint provides a generator to create templates of a context and behaviros.

```bash
$ rails generate blue_print staff user:staff_user
     create  app/blue_prints/staff_context.rb
     create  app/blue_prints/staff_context/staff_user.rb
     invoke  rspec
     create    spec/blue_prints/staff_context_spec.rb
     create    spec/blue_prints/staff_context/staff_user_spec.rb
```

### Contexts

Contexts inherit from `BluePrint::Context`, live in your `app/blue_prints` directory.

#### active_if

This block is used to decide if this context active or not. `env` is the `BluePrint.env`. `self` is passed via `BluePrint::Environment#context`. By default, this is set as `active_if { false }`.

```ruby
class StaffContext < BluePrint::Context
  active_if do |env|
    current_user.try(:staff?)
  end
end
```

And you can define named active if:

```ruby
# lib/active_ifs/staff.rb
BluePrint::ActiveIf.new(:staff) do |env|
  current_user.try(:staff?)
end

# app/blue_prints/staff_context.rb
class StaffContext < BluePrint::Context
  active_if :staff
end
```

#### Casting

Contexts has casting. This is used to decide classes cast as behaviors if this context active.

```ruby
class StaffContext < BluePrint::Context
  cast ::User, as: [StaffUser]
end

StaffContext.casting
# =>
#   {
#     User => [ StaffUser ]
#   }
```

### Behaviors

Behaviors extended by `BluePrint::Behavior`, live in your `app/blue_prints/{context}` directory.

```ruby
# app/blue_prints/staff_context/staff_user.rb
module StaffContext::StaffUser
  extend BluePrint::Behavior
end
```

#### Methods

Behaviors can have some methods.

```ruby
# app/blue_prints/staff_context/staff_user.rb
module StaffContext::StaffUser
  extend BluePrint::Behavior

  def user_name
    "staff"
  end
end

# app/models/user.rb
class User < ActiveRecord::Base
  def user_name
    "#{name} san"
  end
end

user = User.new(name: "Magnet")
user.user_name # => "Magnet san"
within_context_of(StaffContext) do
  user.user_name # => "staff"
end
```

#### Class Methods

Behaviors can have some class methods.

```ruby
# app/blue_prints/staff_context/staff_user.rb
module StaffContext::StaffUser
  extend BluePrint::Behavior

  module ClassMethods
    def find(id)
      where(id: id, staff: true).first!
    end
  end
end

# app/models/user.rb
class User < ActiveRecord::Base
end

user = User.create(staff: false)
User.find(user.id) == user # => true
within_context_of(StaffContext) do
  User.find(user.id) # => raise ActiveRecord::NotFound
end
```

### Helper

`BluePrint::Helper` provides `#within_context_of` method.

This module includes automatically to some classes. see [lib/blue_print/integration](https://github.com/magnet-inc/blue_print/tree/master/lib/blue_print/integration).

## Contributing

1. Fork it ( http://github.com/magnet-inc/blue_print/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
