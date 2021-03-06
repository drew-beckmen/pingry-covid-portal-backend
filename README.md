# Pingry COVID-19 Tracking: Backend API

![Pingry Anywhere](public/Screen%20Shot%202020-09-07%20at%203.00.22%20PM.png)

This repository contains all of the backend code for The Pingry School's internal coronavirus tracking portal. Select people will have full write access to all of the APIs endpoints, and the entire admin team will get access to protected endpoints that share detailed statistics about COVID-19 in the Pingry community. Authentication is handled with JSON Web Tokens, and – as stated previously –  there are two distinct levels of access.

## Ruby Version and System Dependencies

The project uses Rails version 6.0.3 with Ruby 2.6.1. The gem `rack-cors` is used to handle cross-origin resource sharing, and `capistrano` was used to deploy the project with Passenger (application server) and Nginx (web server). 

The backend database uses PostgreSQL. 

## Endpoints: 

### Open Endpoints

There are two open endpoints: 
* `tracking-db.pingryanywhere.org/api/v1/summarystats`
  * This publicly available data is used in Pingry's external facing dashboard, which summarizes many data points related to the virus in the New Jersey area and at Pingry specifically. The external facing dashboard is accessible here: http://dashboard.pingryanywhere.org
* `tracking-db.pingryanywhere.org/api/v1/detailedstats`
  * This publicly available data returns the % of students in quarantine and isolation for each of the last 7 days. It is used on the dashboard so that we can include historical data for backdated quarantines and isolations.

### Protected Endpoints

All remaining endpoints that deal with individual student data and their isolations/quarantines are protected for privacy reasons. 
