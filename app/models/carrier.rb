class Carrier < ActiveRecord::Base
  attr_accessible :name, :is_active
  belongs_to :user
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
