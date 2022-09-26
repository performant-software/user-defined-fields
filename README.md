# UserDefinedFields
This gem is designed to serve and storage and configuration for allowing CMS users to dynamically define fields for their models.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'user_defined_fields'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install user_defined_fields
```

## Usage

#### Migrations
To install the database table necessary to support user defined fields, use the following command:

```bash
bundle exec rails user_defined_fields:install:migrations
```

To install the `user_defined` column on a model, use the following command:

```bash
bundle exec rails generate user_defined_fields:add my_model
```

This will generate the following migration:

```ruby
class AddUserDefinedFieldsToMyModel < ActiveRecord::Migration[7.0]
  def up
    add_column :my_model, :user_defined, :jsonb, default: {}
    add_index :my_model, :user_defined, using: :gin
  end

  def down
    remove_index :my_model, :user_defined
    remove_column :my_model, :user_defined
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
