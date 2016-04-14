class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.binary :file

      t.timestamps null: false
    end
  end
end
