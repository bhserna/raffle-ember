class Entry < ActiveRecord::Base
  self.include_root_in_json = true
  attr_accessible :name, :winner

  def as_json(options = {})
    super only: [:id, :name, :winner]
  end
end
