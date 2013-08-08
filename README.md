# ShotPooter!

A tool for generating BrowserStack screenshots from the command line.

## Installing

For now, clone the repository.

## Configuration

Set up your credentials in the `.browserstack` file in your home
directory. It should look like this:

    username:auth_token 

Next you'll need a browser configuration file. This will be used to
specify which browser versions under which operating systems to take
screenshots. You can start with the sample shipped with this project.

## Using

Use is pretty straightforward:

    ruby screenshots.rb path_to/browsers.yaml

Once the request is successfully made, the program will return the URL
of the screenshot collection.

You don't need to include the URL in your configuration file. It might
be helpful if you're always taking screenshots of the same URL, but
chances are you'll probably want to specify this each time you run the
command.

    ruby screenshots.rb path_to/browsers.yaml -u http://www.github.com

The command accepts an optional boolean flag, `wait`, which will check
every two seconds on the status of the request and return the URL once
the job is complete.
