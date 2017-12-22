require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task default: :spec



task :default do
    FileList['*/**/Rakefile'].each do |project|
        next if project =~ /^admin_console/
        next if project =~ /^logging/
        # clear current tasks
        Rake::Task.clear
        # load tasks from this project
        load project
        if !Rake::Task.task_defined?(:default)
            puts "No default task defined in #{project}, aborting!"
            exit -1
        else
            dir = project.pathmap("%d")
            Dir.chdir(dir) do
                default_task = Rake::Task[:default]
                default_task.invoke()
            end
        end
    end
    puts 'Finished building projects'
end
