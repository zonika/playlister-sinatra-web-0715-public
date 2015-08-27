class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.text :name
      t.belongs_to :artist, index:true
    end
  end
end
