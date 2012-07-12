class Area < ActiveRecord::Base
  belongs_to :city
  attr_accessible :is_active, :name, :city_id
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
