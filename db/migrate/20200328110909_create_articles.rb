class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.column :title,        :string
      t.column :description,  :text
    end
  end
end
