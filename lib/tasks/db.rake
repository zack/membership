namespace :db do
	desc 'This rebuilds development db'
	task :reset do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed_fu"].invoke
	end
end
