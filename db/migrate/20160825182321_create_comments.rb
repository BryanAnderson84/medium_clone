class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.belongs_to :post

      t.timestamps
    end
  end
end
