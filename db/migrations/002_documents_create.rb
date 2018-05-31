# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:documents) do
      primary_key :id
<<<<<<< HEAD
      foreign_key :owner_id, table: :accounts
=======
      foreign_key :owner_id, :accounts
>>>>>>> 2b241693600c56892abc61b2087e8fc97edda6cb

      String :filename_secure, unique: true, null: false
      String :doctype_secure, unique: true
      DateTime :created_time
      DateTime :updated_time
    end
  end
end
