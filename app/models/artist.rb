class Artist < ApplicationRecord
  has_many :lots
  has_many :sales, through: :lots

end
