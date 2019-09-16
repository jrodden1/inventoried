# README

## Description
Inventoried is a webapp built using the Ruby on the Rails framework.  Inventoried is desigend to allow a user to create locations and items then track how much stock of each item is in each location (and track how much total stock there is of an item).

## Pre-Installation Instructions
You will need to contact me at `jrodden1.github@gmail.com` to obtain the correct Facebook omniauth information for that aspect of the app to work.  If you're not going to use your Facebook account to login, this step can be skipped. 

## Install Instructions
After forking and cloning the repo to your local machine, make sure you have `cd`ed into the `inventoried` folder.

If you haven't already, run `bundle install`

*If you want to use the Facebook Authentication, after obtaining the needed information from me, you'll need to create the `.env` file in the root of the app and put in the details I give you and save the file.  Otherwise, skip to the next step.*

Next, run the rails server in one of two ways.

1. If you are using the Facebook Authentication feature, run:
`thin start --ssl`
2. Otherwise, just run the standard:
`rails c`

This will start a local webserver on your machine at `localhost:3000`

To view the web app (and use Facebook Authentication), in your browser of choice, navigate to:
`https://localhost:3000`

Otherwise, if you are not using the Facebook Authetication, navigate to:
`http://localhost:3000`

## Contributors Guide
Please reach out to me at `jrodden1.github@gmail.com` if you'd like to contribute to this repo. 

## License
MIT License - See the License file for more details. 
