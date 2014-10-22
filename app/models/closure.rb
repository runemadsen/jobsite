class Closure < Sequel::Model
  
  def self.create_for_share(share)

    # create row in closure table for this share with depth 0
    self.create(:parent_id => share.id, :child_id => share.id, :depth => 0)

    # run SQL query to calculate for all parents if there is a parent
    if share.parent_id
      DB.run "insert into closures(parent_id, child_id, depth) select p.parent_id, c.child_id, p.depth+c.depth+1 from closures p, closures c where p.child_id=#{share.parent_id} and c.parent_id=#{share.id}"
    end
  end

end