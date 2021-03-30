class Book < ApplicationRecord
  belongs_to :user, optional: true

  enum state: %i[unreserved reserved paid]
end
