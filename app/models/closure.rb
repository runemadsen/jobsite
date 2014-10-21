class Closure < Sequel::Model
  
  def self.create_from_users(sender_id, receiver_id)
    DB.run "insert into closures(parent, child, depth) select p.parent, c.child, p.depth+c.depth+1 from closures p, closures c where p.child=#{sender_id} and c.parent=#{receiver_id}"
  end

end