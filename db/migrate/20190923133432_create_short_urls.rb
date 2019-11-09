class CreateShortUrls < ActiveRecord::Migration[6.0]
   def change
    create_table :short_urls do |t|
      # You'll want to add some attributes here...
      t.string  :title
      t.string  :full_url, null: false
      t.string  :short_code
      t.integer  :click_count, default: 0
      t.timestamps
    end
     add_index :short_urls, :title, unique: true
    add_index :short_urls, :short_code, unique: true
    add_index :short_urls, :click_count
  end
end
