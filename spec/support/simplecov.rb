require 'simplecov'

SimpleCov.start 'rails' do
  minimum_coverage 90
  add_filter ['app/jobs/application_job.rb',
              'app/mailers/application_mailer.rb',
              'app/channels/application_cable',
              'app/admin']
  add_group 'Decorators', 'app/decorators'
  add_group 'Presenters', 'app/presenters'
  add_group 'Queries', 'app/queries'
  add_group 'Services', 'app/services'
  add_group 'Forms', 'app/forms'
end
