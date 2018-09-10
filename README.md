# Cats Shop
Small Sinatra application that returns information about cats available in the shop.

The application is a combination of plain text and JSON endpoints. Currently available endpoints
- `/` - hello page
- `/cats/info` - Read count of cats in database and presents info in readable text

### Assignment
Our company developed and released MVP of this application.
We envision a great potential for the app and would like to keep building it in a fast and reliable way.

In order to achieve stable and productive development, we rely on automated tests. 
However, not all changes can be tested automatically so we would like to have a way to test merged code manually before it is pushed to production.    

Help us build an automated pipeline for any pull requests that:

- Run automated tests on merged code with pull request target
- Deploy code to temporary server for manual testing
- Add comment to the pull request with link to the server
- Destroy server after pull request is closed

As you work on your solution you will inevitably have questions - please send all inquiries via slack. We are happy to assist and help

### Tools
You are free to use any tool, infrastructure, technology you would like. However, it would be nice to see how you can use **AWS** to solve the task.

### Requirements

We would like to see a solution that has following traits:

- Automation - who likes to perform manual steps?
- Configuration - how can we adopt a similar solution for other products/flows/technologies?
- Code - infrastructure/provision/pipelines as a code works the best to: be readable for all engineers, maintain a truth and avoid any hidden manual configurations.

### Setup and run application

#### Setup
Need ruby 2.3.1
- `bundle install` - install dependency
- Configure database in `config/database.yml` or pass configuraton via `DATABASE_URL` (see section below)
- `rake db:create` - create db and run migrations
- `rake db:migrate` - migrate db to latest version
- `rake db:seed` - seed database with basic data
- `rake db:test:prepare` - setup test database based on dev database schema 

#### Run application
- `rackup -p 1234` - Launch web application on port `1234`
#### Run tests
- `rspec`
#### Environment variables
- `DATABASE_URL` - url to database e.g `postgres://{user}:{password}@{hostname}:{port}/{database-name}`
- `RACK_ENV` - environment for the app. possible values: `production`, `development`, `test`

#### Deployment steps
- Server with Docker Registry is required
- Copy run-webhook-container.sh to the instance with docker registry
- Create SSH key pair and import it on AWS with name e.g. access-key. This key will be used for ssh connection to EC2 instances
- Generate GitHub personal access token in the account Developer settings. It's required for pull request comments
- Login to https://travis-ci.com with GitHub account and add needed repository
- In the repository settings add following Environment Variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`, `GITHUB_TOKEN`. Make sure to uncheck option **Display value in build log**. Select in General option **Build pushed pull requests**
- Create first pull reqeust
- Login to docker registry server and execute run-webhook-container.sh script.
- By defult webhook listener use 5001 port. Open GitHub repositry settings and add url for webhooks: http://<registry_public_dns>:5001