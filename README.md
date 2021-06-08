# foodtrack-keeper-bot
TG Bot for my friends (my first experience with bots developement)

## Installation:
 - Install ruby 3.0 or high
 - Instal postgresql server
```bash
 $bundle install
 ```

 ## How to run:
 ```bash
 $ APP_ENV=<ENV (development/production)> API_TOKEN=<TELEGRAM_API_TOKEN> bundle exec ruby bot.rb
```
 ## Tips:
 - After first run and creating database you can seeding it with test data (Use it only in development environment)

 ```bash
 $ psql foodtrack_keeper_dev < config/database/seed.sql 
 ```
It seeds this data:
```
foodtrack_keeper_dev=# select * from categories;
 id |   name    |                                                  description                                                   
----+-----------+----------------------------------------------------------------------------------------------------------------
  1 | Coffee    | Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffea species.
  2 | Pizza     | Yummy hot neapolitan pizza!
  3 | Chocolate | The great dessert for coffee!
(3 rows)

foodtrack_keeper_dev=# select * from items;
 id |       name       |           description            | image | cost | category_id 
----+------------------+----------------------------------+-------+------+-------------
  1 | Capuchino M-size | Espresso + Milk                  |       |    3 |           1
  2 | Capuchino L-size | Espresso + Milk                  |       |    4 |           1
  3 | Margaritta       | The great base pizza with cheese |       |   14 |           2
  4 | BBQ              | Pizza with meat and bbq sauce    |       |   16 |           2
  5 | Mars             | Nuga + chocolate                 |       |    2 |           3
  6 | MilkyWay         | Nuga + milk chocolate            |       |  2.2 |           3
(6 rows)
```
  