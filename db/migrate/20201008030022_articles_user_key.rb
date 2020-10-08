class ArticlesUserKey < ActiveRecord::Migration[6.0]
  def change
    #add_column :table, :field_to_add, datatype
    add_column :articles, :user_id, :int
  end
end
