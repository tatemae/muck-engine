class CreateAccessCodeRequests < ActiveRecord::Migration
  def self.up
    create_table :access_code_requests do |t|
      t.string    :email
      t.datetime  :code_sent_at
      t.timestamps
    end
    add_index :access_code_requests, :email
  end

  def self.down
    drop_table :access_code_requests
  end
end