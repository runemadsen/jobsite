Sequel::Model.plugin(:schema)
DB = Sequel.connect(ENV['DATABASE_URL'])
 
unless DB.table_exists?(:users)
  DB.create_table :users do
    primary_key :id
    String      :name
    String      :email, :null => false
    DateTime    :created_at
    DateTime    :updated_at
  end
end