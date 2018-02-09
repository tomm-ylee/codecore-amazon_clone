class User < ApplicationRecord
  def self.search(search_term)
    self.where('first_name LIKE ? OR last_name LIKE ? OR email like ?', "#{search_term}", "#{search_term}", "#{search_term}")
  end

end
