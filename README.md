# ScreenShooter!

A tool for generating BrowserStack screenshots from the command line.

## Installing

> gem install screenshooter

Or clone the repository and run

> rake install

## Configuration

You will need to provide username and authentication token credentials
to use the service. You can do so with environment variables or using a
file.

To use environment variables (suitable for a CI environment) set
`BROWSERSTACK_USERNAME` and `BROWSERSTACK_TOKEN`, respectively. If these
are missing then ScreenShooter will look for a credentials file.

You should set up your credentials in the `.browserstack` file in your
home directory. It should look like this:

    username:auth_token

Your authentication token is available under the
[automation section](https://www.browserstack.com/accounts/automate-keys)
of your profile.

Next you'll need a browser configuration file. This will be used to
specify which browser versions under which operating systems to take
screenshots. You can start with the sample included in this project,
`sample_browsers.yaml`.

## Using

For each URL provided, screenshooter will return a BrowserStack
screenshot gallery URL.

General use is pretty straightforward:

    screenshooter shoot path_to/browsers.yaml

Once the request is successfully made, the program will return the URL
of the screenshot collection. The URL output can be piped to another
service.

### Commands

    screenshooter browsers list
    screenshooter browsers search
    screenshooter shoot

### Arguments and options

    screenshooter browsers list
    screenshooter browsers search <SEARCH TERM>
    screenshooter shoot -u <URL>
    screenshooter shoot -u <URL> -u <URL> -u <URL>
    screenshooter shoot -u <URL> -b <BROSWER JSON SPEC>

### Setting the URL

You don't need to include the URL in your configuration file. It might
be helpful if you're always taking screenshots of the same URL, but
chances are you'll probably want to specify this each time you run the
command.

    screenshooter shoot path_to/browsers.yaml -u http://www.github.com

### Waiting for completion

The command accepts an optional boolean flag, `wait`, which will check
every 2.5 seconds on the status of the request and return the URL once
the job is complete.

    screenshooter shoot path_to/browsers.yaml -u http://www.github.com -w
    screenshooter shoot path_to/browsers.yaml -u http://www.github.com --wait

### Open the screenshots URL

The command accepts an optional boolean flag, `open`, which will open
the screenshots URL in your default browser.

    screenshooter shoot path_to/browsers.yaml -u http://www.github.com -o
    screenshooter shoot path_to/browsers.yaml -u http://www.github.com --open

