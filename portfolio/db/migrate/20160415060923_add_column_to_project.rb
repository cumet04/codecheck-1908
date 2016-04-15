class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :thumb_id, :int
    add_column :projects, :link_count, :int
  end
end
