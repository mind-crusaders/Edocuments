# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:documents) do
      primary_key :id
      foreign_key :owner_id, :accounts, type: 'uuid'
      String :filename_secure, unique: true, null: false
      String :doctype_secure, unique: true
      DateTime :created_time
      DateTime :updated_time
    end
  end
end
