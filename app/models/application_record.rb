class ApplicationRecord < ActiveRecord::Base
  DeviseTokenAuth::Concerns::User
  primary_abstract_class
end
