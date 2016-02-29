class Setting < ActiveRecord::Base
	has_attached_file :cover_image, default_url: ->(attachment) { ActionController::Base.helpers.asset_path('placeholder.png') }
	validates_attachment :cover_image, :content_type => {:content_type => /\Aimage\/.*\Z/}

	has_attached_file :additional_image, default_url: ->(attachment) { ActionController::Base.helpers.asset_path('placeholder.png') }
	validates_attachment :additional_image, :content_type => {:content_type => /\Aimage\/.*\Z/}


	has_attached_file :facebook_image
	validates_attachment :facebook_image, :content_type => {:content_type => /\Aimage\/.*\Z/}

	has_attached_file :twitter_image
	validates_attachment :twitter_image, :content_type => {:content_type => /\Aimage\/.*\Z/}


	after_save :clear_cache


	MAILCHIMP_API_KEY = nil
	MAILCHIMP_LIST_ID = nil

	def self.cover_image
		(Setting.first || Setting.new).cover_image
	end

	def self.additional_image
		(Setting.first || Setting.new).additional_image
	end

	def self.facebook_image
		(Setting.first || Setting.new).facebook_image
	end

	def self.twitter_image
		(Setting.first || Setting.new).twitter_image
	end

	def self.sharing
		setting = Setting.first || Setting.new
		return {
			twitter_message: setting.twitter_message || "",
			facebook_message: setting.facebook_message || "",
			facebook_title: setting.facebook_title || "",
			linkedin_title: setting.linkedin_title || "",
			linkedin_message: setting.linkedin_message || "",
			whatsapp_message: setting.whatsapp_message || "",
		}
	end

	private

	def clear_cache
		Rails.cache.clear
	end

end
