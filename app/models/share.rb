class Share < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :social_network, :user

	def data
		Setting.sharing
	end

	def redirect_url(root_url)
		send("#{social_network}_link", root_url)
	end

	def facebook_link(root_url)
		"https://www.facebook.com/sharer/sharer.php?u=#{user.referral_url(root_url)}&title=#{data[:facebook_title]}"
	end
	def twitter_link(root_url)
		"https://twitter.com/intent/tweet?text=#{URI.escape(data[:twitter_message])}&url=#{user.referral_url(root_url)}"
	end

	def linkedin_link(root_url)
		"https://www.linkedin.com/shareArticle?mini=true&url=#{user.referral_url(root_url)}&title=#{data[:linkedin_title]}&summary=#{data[:linkedin_message]}&source="
	end
	def whatsapp_link(root_url)
		"whatsapp://send?text=#{URI.escape(data[:whatsapp_message] + " " + user.referral_url(root_url))}"
	end




end
