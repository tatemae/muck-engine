class CreateAccessCodes < ActiveRecord::Migration
  def self.up
    create_table :access_codes do |t|
      t.string    :code
      t.integer   :uses,       :default => 0,     :null => false
      t.boolean   :unlimited,  :default => false, :null => false
      t.datetime  :expires_at
      t.integer   :use_limit,  :default => 1,     :null => false
      t.timestamps
    end
    add_index :access_codes, :code
    add_column :users, :access_code_id, :integer
  end

  def self.down
    drop_table :access_codes
    remove_column :users, :access_code_id
  end
end