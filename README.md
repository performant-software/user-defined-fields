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

### Migrations
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

### Controllers
Each individual field can be configured to be searchable or non-searchable. A searchable field will be included in the query when a user provides the "search" parameter on the API request.

Behind the scenes, this uses the PostgreSQL `jsonb` query syntax to build the SQL used to find the record. For performance reasons, it's important that the GIN index be created on the `user_defined` field (explained above) and that the `user_defined` field doesn't contain nested objects.

```ruby
class MyModelController < ApplicationController
  include UserDefinedFields::Queryable
end
```

### Models
Models that include the `UserDefinedFields::Fieldable` concern will be treated as the models that store the user defined data. The will be available in the dropdown list when configuring user defined fields.

Applications that define user defined fields at the model level should call `resolve_defineable` class method with a lambda function that returns the `defineable` model.

```ruby
class MyModel < ApplicationRecord
  include UserDefinedFields::Fieldable
  
  resolve_defineable -> (my_model) { my_model.parent }
end
```

### Serializers
To include the `user_defined_fields` array as a set of nested attributes, include the `UserDefinedFields::DefineableSerializer` in the serializer for whatever model the user defined fields belong to. This is only necessary for fields defined at the model level.

```ruby
class ParentModelSerializer < BaseSerializer
  include UserDefinedFields::DefineableSerializer
end
```

To include the `user_defined` hash as an attribute, include the `UserDefinedFields::FieldableSerializer` in the model serializer.

```ruby
class MyModelSerializer < BaseSerializer
  include UserDefinedFields::FieldableSerializer
end
```

### Project Architecture

User defined fields can be configured one of two ways: At the application level, or at the model level.

##### Application Level
If configured at the application level, each record in the specified table will contain the same user defined fields.

For example: You could define `first_name` and `last_name` fields for all of the `people` records. Anytime a user is editing a a person form, the `first_name` and `last_name` fields will be available as inputs.

##### Model Level
If configured at the model level, records can contain different fields dependent on a parent record.

For example: You could define a `location` field for `resources` that belong to Project A, then define a `project_stage` field for `resources` that belong to Project B. On the edit for for Project A, only the `location` field will be available. On the edit form for Project B, only the `project_stage` field will be available.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
