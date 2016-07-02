# Robot Directory
An exercise in CRUD (Create Read Update Delete) programming, explored via an interactive website that allows the user to create new robots and edit and delete their existing robots.

Robot Directory utilizes:
* [SQLite3](https://www.sqlite.org/) for its database
* [Bootstrap](http://getbootstrap.com/) for CSS
* ERB for it's views ([HAML](http://haml.info/) is used for the dashboard, as an additional exercise)
* [Pony](https://github.com/benprew/pony) for sending confirmation e-mails
* [Faker](https://github.com/stympy/faker) for generating random robot data

Additionally, basic HTTP authorization is in place to protect the app from unknown individuals.

## Usage
In the terminal, from the root folder of the project (`robot_world`), run `bundle`, then `shotgun`.

In your web browser, navigate to `localhost:9393`. **username and password are both 'admin'**.

Buttons will guide your navigation and creation, viewing, and editing of robots in the directory (database).
