class AddSentToToAccessCodes < ActiveRecord::Migration
  def self.up
    add_column :access_codes, :sent_to, :string
  end

  def self.down
    remove_column :access_codes, :sent_to
  end
end
