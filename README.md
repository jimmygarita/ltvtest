# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc



# Shortener algorithm

We convert from decimal to base 62 because we have 62 characters available for our short code.

In order to have unique short_codes and the possibility of re calculate them, we will convert the db id to base 62.

The algorithm to convert from decimal to another base system is explained in a simple way in [Tutorials Point](https://www.tutorialspoint.com/computer_logical_organization/number_system_conversion.htm)

**Decimal to Other Base System**

Steps

- **Step 1** − Divide the decimal number to be converted by the value of the new base.
- **Step 2** − Get the remainder from Step 1 as the right most digit (least significant digit) of new base number.
- **Step 3** − Divide the quotient of the previous divide by the new base.
- **Step 4** − Record the remainder from Step 3 as the next digit (to the left) of the new base number.
- Repeat Steps 3 and 4, getting remainders from right to left, until the quotient becomes zero in Step 3.
- The last remainder thus obtained will be the Most Significant Digit (MSD) of the new base number.

Once we have the numbers in our base 62 system then we can fetch from the chars list the right letter:

**For instance:**

Db id 1001 in base 62 = [16, 9] = [chars[16], chars[9]] = ['g','9'] = g9 

1001(10) = g9(62)

