class AddUsernameToUsers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    # 1. Ajouter la colonne sans contrainte
    add_column :users, :username, :string, default: nil

    # 2. Générer les usernames pour les utilisateurs existants
    User.reset_column_information

    User.find_each do |user|
      base = user.first_name.to_s.parameterize.presence || "user"
      candidate = nil

      loop do
        rand_number = rand(1000..9999)
        candidate = "#{base}##{rand_number}"
        break unless User.exists?(username: candidate)
      end

      user.update_columns(username: candidate)
    end

    # 3. Appliquer NOT NULL
    change_column_null :users, :username, false

    # 4. Ajouter l'index UNIQUE
    add_index :users, :username, unique: true, algorithm: :concurrently
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end
