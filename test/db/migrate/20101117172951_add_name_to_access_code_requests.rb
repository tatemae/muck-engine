class AddNameToAccessCodeRequests < ActiveRecord::Migration
  def self.up
    add_column :access_code_requests, :name, :string
  end

  def self.down
    remvoe_column :access_code_requests, :name
  end
end
