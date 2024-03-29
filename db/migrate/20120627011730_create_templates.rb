class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.column :tid, :integer
      t.column :name, :string
      t.column :content, :text
    end
  end

  def self.down
    drop_table :templates
  end
end
