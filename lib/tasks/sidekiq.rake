namespace :sidekiq do
	desc 'Strano | Start sidekiq'
	task start: :environment do
		system 'bundle exec sidekiq -C config/sidekiq.yml'
	end
end
