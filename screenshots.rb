require 'rubygems'
require 'thor'
require 'yaml'
require 'screenshot'

# Should get the values from the .browserstack file
def get_credentials
  keypair = File.open("#{Dir.home}/.browserstack", &:readline)
  keypair.strip.split(":")
end

class ShotPooter < Thor
  desc "list", "list systems"
  def list
    username, password = get_credentials
    client = Screenshot::Client.new({"username" => username, "password" => password})
    puts client.get_os_and_browsers
  end

  desc "shoot", "take a screenshot"
  method_option :url, :aliases => "-u", :desc => "URL of page to screenshot"
  method_option :wait, :type => :boolean, :aliases => "-w", :default => false, :desc => "Wait for screenshots to be rendered"
  def shoot(file="browsers.yaml")
    username, password = get_credentials
    client = Screenshot::Client.new({"username" => username, "password" => password})
    params = YAML::load( File.open( file ) )
    if options.has_key? "url"
      params["url"] = options["url"]
    end

    begin
      request_id = client.generate_screenshots params
    rescue Exception => e
      puts e.message
    end

    shot_status = "pending"
    begin
      shot_status = client.screenshots_status request_id
      print "."
      sleep 2
    end while options["wait"] and shot_status != "done"
    puts "\nhttp://www.browserstack.com/screenshots/#{request_id}"
  end
end

ShotPooter.start
