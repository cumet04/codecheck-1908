class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :thumb, :binary
  end
end
