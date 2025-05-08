# temporal-tutorial-ipgeo-ruby# Get Address from IP

This application demonstrates using Temporal by calling two APIs in sequence.
It fetches the user's IP address and then uses that address to geolocate that user.

You can use the app in two ways:

- Through a web front-end
- Through a JSON POST request

In both cases, you provide a name that's included in the greeting.

## Using the app

The app requires the Temporal Service.

First, [Install the Temporal CLI](https://learn.temporal.io/getting_started/ruby/dev_environment/#set-up-a-local-temporal-service-for-development-with-temporal-cli)

Install the dependencies for the project:

```bash
bundle install
```

Then, in another terminal window, start the Temporal Service locally using a database to persist data between runs:

```bash
$ temporal server start-dev --db-filename temporal.db
```

Now launch a new terminal window and start the Temporal Worker:

```bash
ruby lib/worker.rb
```

In a new terminal window, run the client app to start the Workflow:

```bash
ruby lib/ip_geo_ruby.rb Angela
```

In a third terminal window, start the web server to handle API and web requests:

```bash
bundle exec ruby -S rackup server/config.ru -p 3000 -o 0.0.0.0
```

Now visit http://localhost:3000 and enter your name to run the Workflow.

You can also issue a cURL request to start the Workflow:

```bash
curl -X POST http://localhost:3000/api -H "Content-Type: application/json" -d '{"name":"Angela Zhou"}'
```

Visit http://localhost:8233 to view the Event History in the Temporal UI.

Disable your internet connection and try again. This time you'll see the Workflow pause. Restore the internet connection and the Workflow completes.