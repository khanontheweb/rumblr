class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :tags
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
