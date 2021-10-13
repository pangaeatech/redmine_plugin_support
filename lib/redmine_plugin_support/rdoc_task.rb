require 'rdoc/task'

module RedminePluginSupport
  class RDocTask < GeneralTask
    def define

      desc "Generate documentation for XXX"
      RDoc::Task.new(:doc) do |rdoc|
        rdoc.rdoc_dir = 'doc'
        rdoc.title    = Base.instance.project_name
        rdoc.options << '--line-numbers' << '--inline-source'
        rdoc.rdoc_files.include('README.rdoc')
        rdoc.rdoc_files.include('lib/**/*.rb')
        rdoc.rdoc_files.include('app/**/*.rb')
      end
      self
    end
    
  end
end
