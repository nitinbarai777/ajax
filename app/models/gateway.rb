class Gateway < ActiveRecord::Base
  attr_accessible :is_active, :name
  belongs_to :user
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
