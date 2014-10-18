module Madsen
  module Helpers
    module Params
      def validate_params!(hash, *keys)
        nils = keys.select { |k| hash[k].nil? }
        if nils.size > 0
          raise Madsen::MissingArgument.new(*nils) 
        end
        # return hash with those keys
        hash.select {|k,v| keys.include?(k) }
      end
    end
  end
end