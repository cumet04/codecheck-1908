class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :thumb_id, :int
  end
end
