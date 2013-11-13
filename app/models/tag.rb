class Tag < ActiveRecord::Base

  def self.search(search)
  if search
  	where('name LIKE ?', "%#{search}%")
  else
    find(:all)
  end
end
end
