# CoderJobs

A job board application using Phoenix Framework

![My Image](https://raw.githubusercontent.com/johndavedecano/CoderJobs/master/screenshot.png)

## Features

* Registration, Login, Forgot Password, Reset Password
* Manage Jobs, Search, Create, Update, Delete
* Newsletter Integration
* Static Pages
* RichText Editor for job description

## Milestone

* Ability to send CV from the job page.
* Mailchimp newsletter integration
* Job to archive expired posts
* Administration Panel
* Blogs
* Report Post

## Development

* Edit .env.example with your own configs and save it as .env.
* Then apply env variables to your system `source .env`
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `cd assets && npm install`
* Build brunch `node_modules/.bin/brunch build`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please
[check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

* Author URL: http://johndavedecano.me
* Official website: http://www.phoenixframework.org/
* Guides: http://phoenixframework.org/docs/overview
* Docs: https://hexdocs.pm/phoenix
* Mailing list: http://groups.google.com/group/phoenix-talk
* Source: https://github.com/phoenixframework/phoenix
