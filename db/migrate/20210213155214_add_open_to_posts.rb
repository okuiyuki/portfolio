class AddOpenToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :open, :boolean, default: true, null: false
  end
end
