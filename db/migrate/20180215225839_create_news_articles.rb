class CreateNewsArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :description
      t.datetime :published_at
      t.references :user, foreign_key: true
      t.integer :view_count

      t.timestamps
    end
  end
end
