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

### Models
Models that include the `UserDefinedFields::Fieldable` concern will be treated as the models that store the user defined data. The will be available in the dropdown list when configuring user defined fields.

Applications that define user defined fields at the model level should call `resolve_defineable` class method with a lambda function that returns the `defineable` model.
```ruby
class MyModel < ApplicationRecord
  include UserDefinedFields::Fieldable
  
  resolve_defineable -> (my_model) { my_model.parent }
end
```

### Components

User defined fields can be configured one of two ways: At the application level, or at the model level.

##### Application Level
If configured at the application level, each record in the specified table will contain the same user defined fields.

For example: You could define `first_name` and `last_name` fields for all of the `people` records. Anytime a user is editing a a person form, the `first_name` and `last_name` fields will be available as inputs.

```jsx
<UserDefinedFieldsList />
```

##### Model Level
If configured at the model level, records can contain different fields dependent on a parent record.

For example: You could define a `location` field for `resources` that belong to Project A, then define a `project_stage` field for `resources` that belong to Project B. On the edit for for Project A, only the `location` field will be available. On the edit form for Project B, only the `project_stage` field will be available.

```jsx
<UserDefinedFieldsEmbeddedList
  items={props.item.user_defined_fields}
  onDelete={props.onDeleteChildAssociation.bind(this, 'user_defined_fields')}
  onSave={props.onSaveChildAssociation.bind(this, 'user_defined_fields')}
/>
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
