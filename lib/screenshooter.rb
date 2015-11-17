require 'rubygems'
require 'thor'
require 'yaml'
require 'launchy'
require 'progress_bar'
require 'screenshot'
require "screenshooter/version"

# Should get the values from the .browserstack file
def get_credentials
  if ENV['BROWSERSTACK_USERNAME'] and ENV['BROWSERSTACK_TOKEN']
    [ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_TOKEN']]
  else
    keypair = File.open("#{Dir.home}/.browserstack", &:readline)
    keypair.strip.split(":")
  end
end

module ScreenShooter

  class ShotMaster < Thor
    desc "list", "list systems"
    def list
      username, password = get_credentials
      client = Screenshot::Client.new({"username" => username, "password" => password})
      puts client.get_os_and_browsers
    end

    desc "shoot", "take a screenshot"
    method_option :url, :aliases => "-u", :desc => "URL of page to screenshot"
    method_option :wait, :type => :boolean, :aliases => "-w", :default => false, :desc => "Wait for screenshots to be rendered?"
    method_option :open, :type => :boolean, :aliases => "-o", :default => false, :desc => "Open the URL in the browser?"
    method_option :quiet, :type => :boolean, :aliases => "-q", :default => false, :desc => "Don't show progress bar"
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
      bar = ProgressBar.new(:elapsed) unless options[:quiet]
      begin
        shot_status = client.screenshots_status request_id
        sleep 2.5
        bar.increment! unless options[:quiet]
      end while options["wait"] and shot_status != "done"

      screenshots_url = "http://www.browserstack.com/screenshots/#{request_id}"
      if options["open"]
        Launchy.open(screenshots_url)
      else
        puts screenshots_url
      end
    end
  end
end
