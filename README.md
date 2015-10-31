Beacon
====


Project Description
===========

Have you ever tried to find help from a mental health professional? If so then you know how difficult it can be at times. That difficulty is compounded when you are struggling with your own issues.

That is where 'Beacon' comes in. Our app provides an easy, clickable interface that asks users how they are feeling and immediately gives them results of mental health professionals in their area. Users can also refine their searches by different parameters such as zip code, distance, insurance, and specifying the age range that a professional specializes in.

'Beacon' strives to make the road to better mental health extremely easy with as little frustration to the user as possible.

Under the Hood
===========

![Mordor](/process/psych_today.jpg)

'Beacon' runs on RAILS under the hood and has utilized Nokogiri to create databases, Mandrill for email communication with providers, and JavaScript/jQuery to provide an easy to use, single page user experience.

Schema:
![schema](/db/doc/schema.png)

Using the Web App
===========

[Beacon](http://light-the-beacon.com)

Simply visit the web page and start selecting how you feel from the different selections we have provided.

As you click you will be provided with immediate results of mental health professionals in your area. The more you click, the more refined your search becomes.

You can also utilize the refined search box on the left side of the page to add parameters to your search.

Installing 'Beacon'
===========

From the Command Line, run:

```
git clone https://github.com/wolves-2014/hmhy.git
  => clones the git repository locally
```

```
bundle install
  => installs the necessary gems
```

```
rake db:create
  => creates your database
```

```
rake db:migrate
  => adds table to the database
```

```
rake db:seed
  => loads up the database (WARNING: This process takes some time to load all providers so consider limiting the seed if you are merely previewing the site.)
```

Contributors
===========

Ryan Milstead: [@ryanmilstead1](https://github.com/RyanMilstead1)


Richard Baptist: [@rpaptist](https://github.com/rpbaptist)


Jordan Schreuder: [@mjsteichen](https://github.com/mjsteichen)


David Lamps: [@luminous14](https://github.com/luminous14)

Trello Board:
[Trello Board](https://trello.com/b/dhwlDZjP/help-me-help-you)
