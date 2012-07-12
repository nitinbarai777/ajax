class City < ActiveRecord::Base
  attr_accessible :is_active, :name
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
