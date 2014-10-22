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

unless DB.table_exists?(:logins)
  DB.create_table :logins do
    primary_key :id
    foreign_key :user_id, :users
    String      :token
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:jobs)
  DB.create_table :jobs do
    primary_key :id
    String      :company
    String      :title
    String      :description, :text=>true
    DateTime    :created_at
    DateTime    :updated_at
  end
end

unless DB.table_exists?(:shares)
  DB.create_table :shares do
    primary_key :id
    foreign_key :job_id, :jobs          # id of job that this share belongs to
    foreign_key :sender_id, :users      # id of user that created the share
    foreign_key :receiver_id, :users    # id of user that received the share
    Integer     :parent_id              # the parent share that this share came from
    DateTime    :created_at
    DateTime    :updated_at
  end
end

# THE CLOSURE NEEDS INDEXING!!!
unless DB.table_exists?(:closures)
  DB.create_table :closures do
    primary_key :id
    Integer :parent_id
    Integer :child_id
    Integer :depth
  end
end