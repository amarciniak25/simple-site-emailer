require 'optparse'
require 'ostruct'
require 'open-uri'
require 'mail'

# Parse command line input
options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-s', '--site SITE', 'URL to be checked') { |o| options.site = o }
  opt.on('-p', '--pattern PATTERN', 'search string') { |o| options.pattern = o }
  opt.on('-a', '--address ADDRESS', 'SMTP Server') { |o| options.address = o }
  opt.on('-u', '--user USER', 'Mail username') { |o| options.user = o }
  opt.on('-s', '--pass PATTERN', 'Mail password') { |o| options.pass = o }
  opt.on('-d', '--domain DOMAIN', 'Mail domain') { |o| options.domain = o }
  opt.on('-e', '--email EMAIL', 'email address') { |o| options.email = o }
end.parse!

# Setup the mailer
mailoptions = { :address => options.address, :port => 587, :domain => options.domain, :user_name => options.user, :password => options.pass, :authentication  => 'plain', :enable_starttls_auto => true }
Mail.defaults do
  delivery_method :smtp, mailoptions
end

# Open URL
source = open(options.site, &:read)

# Look for pattern
if source.include? options.pattern
	#Do Nothing
else
	Mail.deliver do
      to options.email
     	from options.email
  		subject options.site + ' is Down'
     	body options.site + ' is Down'
	end
end