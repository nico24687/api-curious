class User < ApplicationRecord

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(github_token: auth_hash["credentials"]["token"]) do |user|
      user.nickname = auth_hash["info"]["nickname"]
      user.name = auth_hash["info"]["name"]
    end
  end
end
