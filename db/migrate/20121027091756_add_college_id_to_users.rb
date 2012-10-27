class AddCollegeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :college_id, :integer
    add_index :users, :college_id
  end
end
