gem 'rspec'
gem 'rspec-rails'
require 'rspec/core/rake_task'

module RedminePluginSupport
  class RspecTask < GeneralTask
    def define

      desc "Run all specs in spec directory (excluding plugin specs)"
      RSpec::Core::RakeTask.new(:spec) do |t|
        t.rspec_opts = ['-f failures', "-r \"#{RedmineHelper.plugin_root}/spec/spec_helper.rb\""]
        t.pattern = 'spec/**/*_spec.rb'
      end
      
      namespace :spec do
        desc "Run all specs in spec directory with RCov (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:rcov) do |t|
          t.rspec_opts = ['-f failures', "-r \"#{RedmineHelper.plugin_root}/spec/spec_helper.rb\""]
          t.pattern = 'spec/**/*_spec.rb'
          t.rcov = true
          t.rcov_opts << ["--rails", "--sort=coverage", "--exclude '/var/lib/gems,spec,#{RedmineHelper.redmine_app},#{RedmineHelper.redmine_lib}'"]
        end
        
        desc "Print Specdoc for all specs (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:doc) do |t|
          t.rspec_opts = ['-f failures', "-r \"#{RedmineHelper.plugin_root}/spec/spec_helper.rb\""]
          t.pattern = 'spec/**/*_spec.rb'
        end

        desc "Print Specdoc for all specs as HTML (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:htmldoc) do |t|
          t.rspec_opts = ['-f failures', "-r \"#{RedmineHelper.plugin_root}/spec/spec_helper.rb\""]
          t.pattern = 'spec/**/*_spec.rb'
        end

        [:models, :controllers, :views, :helpers, :lib].each do |sub|
          desc "Run the specs under spec/#{sub}"
          RSpec::Core::RakeTask.new(sub) do |t|
            t.rspec_opts = ['-f failures', "-r \"#{RedmineHelper.plugin_root}/spec/spec_helper.rb\""]
            t.pattern = "spec/#{sub}/**/*_spec.rb"
          end
        end
      end

      
      self
    end
    
  end
end
