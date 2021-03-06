class UsersDAO
	def self.validate_email( email )
		User.exists_user_with_email( email )
	end

	def self.create_user( user_h )
		latitude = user_h[:latitude]
		longitude = user_h[:longitude]
		user_h[:city] = City.load_city_by_position( latitude, longitude )

		user_h[:interests] = Interest.load_interests_by_ids( user_h[:interests] )
		User.create( user_h )
	end

	def self.update_user( id, user_h )
		user = User.load_user_by_id( id )

		user_h[:interests] = Interest.load_interests_by_ids( user_h[:interests] )
		user.update( user_h )

		return user
	end

	def self.delete_user( id )
		user = User.load_user_by_id( id )
		if user == nil
			return false
		end

		user.destroy
		return true
	end
end
