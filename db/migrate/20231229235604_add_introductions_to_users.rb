class AddIntroductionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :string
  end
end
