# ScreenShooter!

A tool for generating BrowserStack screenshots from the command line.

## Installing

> gem install screenshooter

Or clone the repository and run

> rake install

## Configuration

Set up your credentials in the `.browserstack` file in your home
directory. It should look like this:

    username:auth_token
    
Your authentication token is available under the
[automation section](https://www.browserstack.com/accounts/automate-keys)
of your profile.

Next you'll need a browser configuration file. This will be used to
specify which browser versions under which operating systems to take
screenshots. You can start with the sample included in this project,
`sample_browsers.yaml`.

## Using

Use is pretty straightforward:

    screenshooter path_to/browsers.yaml

Once the request is successfully made, the program will return the URL
of the screenshot collection. The URL output can be piped to another
service.

### Setting the URL

You don't need to include the URL in your configuration file. It might
be helpful if you're always taking screenshots of the same URL, but
chances are you'll probably want to specify this each time you run the
command.

    screenshooter path_to/browsers.yaml -u http://www.github.com

### Waiting for completion

The command accepts an optional boolean flag, `wait`, which will check
every 2.5 seconds on the status of the request and return the URL once
the job is complete.

    screenshooter path_to/browsers.yaml -u http://www.github.com -w
    screenshooter path_to/browsers.yaml -u http://www.github.com --wait
    
### Open the screenshots URL

The command accepts an optional boolean flag, `open`, which will open
the screenshots URL in your default browser.

    screenshooter path_to/browsers.yaml -u http://www.github.com -o
    screenshooter path_to/browsers.yaml -u http://www.github.com --open
