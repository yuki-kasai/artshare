class CreatePostComments < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comments do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
